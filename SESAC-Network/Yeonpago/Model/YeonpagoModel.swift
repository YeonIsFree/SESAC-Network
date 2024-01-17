//
//  Model.swift
//  SESAC-Network
//
//  Created by Seryun Chun on 2024/01/17.
//

import Foundation

struct Papago: Codable {
    let message: PapagoResult
}

struct PapagoResult: Codable {
    let result: PapageMessage
}

struct PapageMessage: Codable {
    let srcLangType: String
    let tarLangType: String
    let translatedText: String
}
