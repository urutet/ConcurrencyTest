//
//  ValueManagerProtocol.swift
//  MultithreadingTest
//
//  Created by Vadim on 10.03.22.
//

protocol ValueManagerProtocol: AnyObject {
    var value: Int { get }
    func changeValue(_: Int)
}
