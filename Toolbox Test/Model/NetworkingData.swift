//
//  NetworkingData.swift
//  Toolbox Test
//
//  Created by Edward Pizzurro Fortun on 2/11/21.
//

import Foundation

struct NetworkingData {
    
    let baseURL = "https://echo-serv.tbxnet.com/"
    
    func  getBaseURL() -> String {
        return baseURL
    }
}

enum NetworkingError: Error {
    case badUrl
    case badResponse
}
