//
//  CarruselData.swift
//  Toolbox Test
//
//  Created by Edward Pizzurro Fortun on 2/11/21.
//

import Foundation

struct CarruselesData: Decodable {
    let title: String
    let type: String
    let items: [Carrusel]
}

struct Carrusel: Decodable {
    let title: String
    let imageUrl: String
    let videoUrl: String?
    let description: String
}

struct CarruselesErrorResponse: Decodable, LocalizedError {
    let code: String
    let message: String
    let detail: String
    let status: Int
}
