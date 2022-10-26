//
//  AgeProvider.swift
//  MultithreadingTest
//
//  Created by Vadim on 10.03.22.
//

import Foundation

final class AgeProvider {
  
  func age(completion: @escaping (Int) -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
      completion(Int.random(in: 18...60))
    }
  }
}
