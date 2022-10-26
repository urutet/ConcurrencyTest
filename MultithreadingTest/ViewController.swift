//
//  ViewController.swift
//  MultithreadingTest
//
//  Created by Vadim on 10.03.22.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet private weak var imageView: UIImageView!
  @IBOutlet private weak var nameLabel: UILabel!
  @IBOutlet private weak var ageLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    testDataRace(
       valueManagers: [
        SemaphoreValueManager(),
        NSLockValueManager(),
        IsolationQueueValueManager(),
        SerialPriorityQueueValueManager()
       ]
    )
    
    testThreadSynchronization()
  }

  private func testDataRace(valueManagers: [ValueManagerProtocol]) {
    valueManagers.forEach { valueManager in
      DispatchQueue.concurrentPerform(iterations: 100) { _ in
        valueManager.changeValue(Int.random(in: -50...50))
        print(valueManager.value)
      }
    }
  }
  
  private func testThreadSynchronization() {
    // You have to sync all the work below
    // It should fulfill all UI elements only after all requests are finished
    // You can use any instruments that you wish that wouldn't brake UI thread and all requests would run in parallel (except of reactive ones (RxSwift, Combine, etc.))
    // Also pay attention to any memory leaks or retain cycles
    var image: UIImage?
    var nameS: String?
    var ageI: Int?
    
    let dispatchGroup = DispatchGroup()
    
    dispatchGroup.enter()
    ImageProvider().image { result in
      // unwrap result and assign image to imageView (if success) or nil (if failure)
        switch result {
        case .success(let img):
            image = img
        case .failure(_):
            image = nil
        }
        dispatchGroup.leave()
    }
    
    dispatchGroup.enter()
    NameProvider().name { name in
      // assign name to nameLabel
        nameS = name
        dispatchGroup.leave()
    }
    
    dispatchGroup.enter()
    AgeProvider().age { age in
      // assign age to ageLabel in format "Age: 15"
        ageI = age
        dispatchGroup.leave()
    }
    
    dispatchGroup.notify(queue: .main) {
        self.imageView.image = image
        self.nameLabel.text = nameS
        if let age = ageI {
            self.ageLabel.text = "Age: \(age)"
        }
    }
  }
}

