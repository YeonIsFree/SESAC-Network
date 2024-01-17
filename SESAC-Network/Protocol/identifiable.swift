//
//  identifiable.swift
//  SESAC-Network
//
//  Created by Seryun Chun on 2024/01/17.
//

import Foundation

protocol Indentifiable {
    static var identifier: String { get }
}

extension Identifiable {
    static var identifier: String {
        return String(describing: self)
    }
}

extension NSObject: Identifiable {}
