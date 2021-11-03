//
//  CarruselService.swift
//  Toolbox Test
//
//  Created by Edward Pizzurro Fortun on 2/11/21.
//

import Foundation

class CarruselesService {
    
    let baseUrl = NetworkingData().baseURL
    
    func getCarruseles(completion: @escaping (Result<[CarruselesData], Error>)-> Void) {
        
        let urlString =  baseUrl + "v1/mobile/data"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkingError.badUrl))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("\(UserDefaults.standard.string(forKey: "token_type")!) \(UserDefaults.standard.string(forKey: "token_access")!)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared

        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {

                if let unwrappedError = error {
                    completion(.failure(unwrappedError))
                    return
                }

                if let unwrappedData = data {
                    do{
                        let json = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
                        print("JSON JAJAJAJAJAJAJA")
                        print(json)

                        if let successRes = try? JSONDecoder().decode([CarruselesData].self, from: unwrappedData){
                            completion(.success(successRes))
                        }else{

                            let errorResponse = try JSONDecoder().decode(CarruselesErrorResponse.self, from: unwrappedData)
                            print("Error \(errorResponse)")
                            completion(.failure(errorResponse))
                        }
                    }catch{
                        completion(.failure(error))
                    }
                }
            }
        }
        task.resume()
    }
}

