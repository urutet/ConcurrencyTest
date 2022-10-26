//
//  AtomicValueManager.swift
//  MultithreadingTest
//
//  Created by Yushkevich Ilya on 11.03.22.
//

import Foundation

final class IsolationQueueValueManager: ValueManagerProtocol {
    private let isolationQueue: DispatchQueue
    private var isolatedValue: Int

    var value: Int {
        get {
            var result = 0
            isolationQueue.sync {
                result = self.isolatedValue
            }
            return result
        }
        set(value) {
            isolationQueue.async(flags: .barrier) {
                self.isolatedValue = value
            }
        }
    }
    
    
    init(value: Int = 0) {
        isolatedValue = value
        isolationQueue = DispatchQueue(
            label: "iTechArtInternship.MultithreadingTest.IsolationQueue",
            attributes: .concurrent
        )
    }
    
    func changeValue(_ value: Int) {
        self.value += value
    }
    
    
}
