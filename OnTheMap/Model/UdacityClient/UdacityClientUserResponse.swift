//
//  UdacityClientUserResponse.swift
//  OnTheMap
//
//  Created by Ty Hopp on 7/12/21.
//

import Foundation

struct UdacityClientUserResponse: Codable {
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case firstName, lastName
    }
}
