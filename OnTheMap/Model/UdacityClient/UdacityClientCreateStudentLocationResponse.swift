//
//  UdacityClientCreateStudentLocationResponse.swift
//  OnTheMap
//
//  Created by Ty Hopp on 6/12/21.
//

import Foundation

struct UdacityClientCreateStudentLocationResponse: Codable {
    let createdAt: String
    let objectId: String
    
    enum CodingKeys: String, CodingKey {
        case createdAt, objectId
    }
}
