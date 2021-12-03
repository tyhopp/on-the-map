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
    
    enum Endpoint {
        static let session = URL(string: "https://onthemap-api.udacity.com/v1/session")!
    }
    
    // MARK: Requests
    
    class func login(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        let payload = UdacityClientLoginRequest(udacity: .init(username: username, password: password))
        let body = try! JSONEncoder().encode(payload)
        
        requestTask(url: Endpoint.session, method: "POST", headers: nil, body: body, responseType: UdacityClientLoginResponse.self) { response, error in
            if let response = response {
                Auth.sessionId = response.session.id
                Auth.sessionExpiration = response.session.expiration
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    class func logout(completion: @escaping (Bool, Error?) -> Void) {
        var headers: [String: String] = [:]
        
        var xsrfCookie: HTTPCookie? = nil
        
        for cookie in HTTPCookieStorage.shared.cookies! {
          if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        
        if let xsrfCookie = xsrfCookie {
          headers["X-XSRF-TOKEN"] = xsrfCookie.value
        }
        
        requestTask(url: Endpoint.session, method: "DELETE", headers: headers, responseType: UdacityClientLogoutResponse.self) { response, error in
            if let _ = response {
                Auth.sessionId = ""
                Auth.sessionExpiration = ""
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    // MARK: Generic tasks
    
    private class func requestTask<ResponseType: Decodable>(url: URL, method: String = "GET", headers: [String: String]?, body: Data? = nil, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) {
        
        var request = URLRequest(url: url)
        
        request.httpMethod = method
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let headers = headers {
            for (headerKey, headerValue) in headers {
                request.addValue(headerValue, forHTTPHeaderField: headerKey)
            }
        }
        
        if let body = body {
            request.httpBody = body
        }
        
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
