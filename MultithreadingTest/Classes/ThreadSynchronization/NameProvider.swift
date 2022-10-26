//
//  NameProvider.swift
//  MultithreadingTest
//
//  Created by Vadim on 10.03.22.
//

import Foundation

final class NameProvider {
  
  private let names = ["Ilya Yushkevich", "Vadim Shikulo"]
  
  func name(completion: @escaping (String) -> Void) {
    DispatchQueue.global().asyncAfter(deadline: .now() + 1) { [names] in
      completion(names.randomElement()!)
    }
  }
}
