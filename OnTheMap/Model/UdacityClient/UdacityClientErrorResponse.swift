//
//  UdacityClientErrorResponse.swift
//  OnTheMap
//
//  Created by Ty Hopp on 10/11/21.
//

import Foundation

struct UdacityClientErrorResponse: Codable, Error {
    let status: Int
    let error: String
    
    enum CodingKeys: String, CodingKey {
        case status
        case error
    }
}
