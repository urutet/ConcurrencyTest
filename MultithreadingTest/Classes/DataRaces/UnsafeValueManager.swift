//
//  UnsafeValueManager.swift
//  MultithreadingTest
//
//  Created by Vadim on 10.03.22.
//

import Foundation

// Don't use it. It is just an example of thread unsafe code
final class UnsafeValueManager: ValueManagerProtocol {
    
    private(set) var value: Int
    
    init(value: Int = 0) {
        self.value = value
    }
  
    func changeValue(_ change: Int) {
        value += change
    }
}
