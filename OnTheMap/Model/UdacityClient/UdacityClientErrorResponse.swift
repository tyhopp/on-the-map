//
//  UdacityClientErrorResponse.swift
//  OnTheMap
//
//  Created by Ty Hopp on 10/11/21.
//

import Foundation

struct UdacityClientErrorResponse: Codable, LocalizedError {
    let error: String
    
    enum CodingKeys: String, CodingKey {
        case error
    }
    
    var errorDescription: String? {
        return error
    }
}
