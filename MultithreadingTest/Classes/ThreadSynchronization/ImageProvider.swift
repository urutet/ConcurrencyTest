//
//  ImageProvider.swift
//  MultithreadingTest
//
//  Created by Vadim on 10.03.22.
//

import Foundation
import UIKit

final class ImageProvider {
  
  enum Error: Swift.Error {
    case unknown
  }
  
  func image(completion: @escaping (Result<UIImage, Error>) -> Void) {
    DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
      if Bool.random() {
        completion(.success(UIImage(named: "Image")!))
      } else {
        completion(.failure(.unknown))
      }
    }
  }
}
