//
//  UdacityClientLoginResponse.swift
//  OnTheMap
//
//  Created by Ty Hopp on 10/11/21.
//

import Foundation

struct UdacityClientLoginResponse: Codable {
    let account: Account
    let session: Session
    
    struct Account: Codable {
        let registered: Bool
        let key: String
        
        enum CodingKeys: String, CodingKey {
            case registered, key
        }
    }
    
    struct Session: Codable {
        let id: String
        let expiration: String
        
        enum CodingKeys: String, CodingKey {
            case id, expiration
        }
    }
}
