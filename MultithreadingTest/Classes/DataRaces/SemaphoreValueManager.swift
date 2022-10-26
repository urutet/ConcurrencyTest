//
//  ValueManager.swift
//  MultithreadingTest
//
//  Created by Yushkevich Ilya on 11.03.22.
//

import Foundation

final class SemaphoreValueManager: ValueManagerProtocol {
    private var semaphore: DispatchSemaphore
    private var lockableValue: Int

    var value: Int {
        get {
            semaphore.wait()
            let i = self.lockableValue
            semaphore.signal()
            return i
        }
        set(value) {
            semaphore.wait()
            self.lockableValue = value
            semaphore.signal()
        }
    }
    
    
    
    init(_ value: Int = 0) {
        semaphore = DispatchSemaphore(value: 1)
        lockableValue = value
    }
    
    func changeValue(_ value: Int) {
        self.value += value
    }
}
