//
//  ValueManager.swift
//  MultithreadingTest
//
//  Created by Yushkevich Ilya on 11.03.22.
//

import Foundation

final class NSLockValueManager: ValueManagerProtocol {
    private var lock: NSLock
    private var lockableValue: Int

    var value: Int {
        get {
            lock.lock()
            let i = self.lockableValue
            lock.unlock()
            return i
        }
        set(value) {
            lock.lock()
            self.lockableValue = value
            lock.unlock()
        }
    }
    
    
    
    init(_ value: Int = 0) {
        lock = NSLock()
        lockableValue = value
    }
    
    func changeValue(_ value: Int) {
        self.value += value
    }
}
