//
//  UdacityClientLoginRequest.swift
//  OnTheMap
//
//  Created by Ty Hopp on 10/11/21.
//

import Foundation

struct UdacityClientLoginRequest: Codable {
    let udacity: Credentials
    
    struct Credentials: Codable {
        let username: String
        let password: String
        
        enum CodingKeys: String, CodingKey {
            case username, password
        }
    }
}
