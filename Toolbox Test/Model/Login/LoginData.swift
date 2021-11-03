//
//  LoginData.swift
//  Toolbox Test
//
//  Created by Edward Pizzurro Fortun on 2/11/21.
//

import Foundation

struct LoginQueryData: Codable {
    let sub: String
}

struct LoginResData: Codable {
    let sub: String
    let token: String
    let type: String
}

struct LoginErrorResponse: Decodable, LocalizedError {
    let code: String
    let message: String
    let detail: String
    let status: Int
}
