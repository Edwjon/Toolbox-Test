//
//  LoginService.swift
//  Toolbox Test
//
//  Created by Edward Pizzurro Fortun on 2/11/21.
//

import Foundation

class LoginService {
    
    let baseUrl = NetworkingData().baseURL
    
    func login(parametros: LoginQueryData,
                completion: @escaping (Result<LoginResData, Error>)-> Void) {
        
        let urlString =  baseUrl + "v1/mobile/auth"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkingError.badUrl))
            return
        }
        
        let json: [String: Any] = ["sub": "\(parametros.sub)"]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        var request = URLRequest(url: url)
        request.httpBody = jsonData
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

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
                        print("JSON AQUi")
                        print(json)

                        if let successRes = try? JSONDecoder().decode(LoginResData.self, from: unwrappedData){
                            completion(.success(successRes))
                        }else{

                            let errorResponse = try JSONDecoder().decode(LoginErrorResponse.self, from: unwrappedData)
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
