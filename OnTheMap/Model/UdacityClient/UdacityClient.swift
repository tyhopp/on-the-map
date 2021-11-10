//
//  UdacityClient.swift
//  OnTheMap
//
//  Created by Ty Hopp on 10/11/21.
//

import Foundation

class UdacityClient {
    
    struct Auth {
        static var sessionId = ""
        static var sessionExpiration = ""
    }
    
    enum Endpoints {
        static let login = URL(string: "https://onthemap-api.udacity.com/v1/session")!
    }
    
    // MARK: Requests
    
    class func login(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        let body = UdacityClientLoginRequest(udacity: .init(username: username, password: password))
        getRequestTask(url: Endpoints.login, responseType: UdacityClientLoginResponse.self, body: body) { response, error in
            if let response = response {
                Auth.sessionId = response.session.id
                Auth.sessionExpiration = response.session.expiration
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    // MARK: Generic tasks
    
    private class func getRequestTask<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(body)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard var data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            // Remove first 5 characters Udacity API has for security
            data = data.subdata(in: 5..<data.count)
            
            let decoder = JSONDecoder()
            
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(UdacityClientErrorResponse.self, from: data) as Error
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        
        task.resume()
    }
}
