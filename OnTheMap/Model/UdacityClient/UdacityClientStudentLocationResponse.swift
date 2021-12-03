//
//  UdacityClientStudentLocationResponse.swift
//  OnTheMap
//
//  Created by Ty Hopp on 3/12/21.
//

import Foundation

struct UdacityClientStudentLocationResponse: Codable {
    let results: [StudentLocation]
    
    struct StudentLocation: Codable {
        let createdAt: String
        let firstName: String
        let lastName: String
        let latitude: Float
        let longitude: Float
        let mapString: String
        let mediaURL: String
        let objectId: String
        let uniqueKey: String
        let updatedAt: String

        enum CodingKeys: String, CodingKey {
            case createdAt
            case firstName
            case lastName
            case latitude
            case longitude
            case mapString
            case mediaURL
            case objectId
            case uniqueKey
            case updatedAt
        }
    }
}
