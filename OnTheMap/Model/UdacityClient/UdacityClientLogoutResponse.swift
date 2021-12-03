//
//  UdacityClientLogoutResponse.swift
//  OnTheMap
//
//  Created by Ty Hopp on 3/12/21.
//

import Foundation

struct UdacityClientLogoutResponse: Codable {
    let session: Session
    
    struct Session: Codable {
        let id: String
        let expiration: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case expiration
        }
    }
}
