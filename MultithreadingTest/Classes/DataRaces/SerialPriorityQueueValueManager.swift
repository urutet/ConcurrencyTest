//
//  AtomicValueManager.swift
//  MultithreadingTest
//
//  Created by Yushkevich Ilya on 11.03.22.
//

import Foundation

final class SerialPriorityQueueValueManager: ValueManagerProtocol {
    private let serialPriorityQueue: DispatchQueue
    private var isolatedValue: Int

    var value: Int {
        get {
            var result = 0
            serialPriorityQueue.sync {
                result = self.isolatedValue
            }
            return result
        }
        set(value) {
            serialPriorityQueue.async {
                self.isolatedValue = value
            }
        }
    }
    
    
    init(value: Int = 0) {
        isolatedValue = value
        serialPriorityQueue = DispatchQueue(
            label: "iTechArtInternship.MultithreadingTest.SerialPriorityQueue"
        )
    }
    
    func changeValue(_ value: Int) {
        self.value += value
    }
    
    
}
