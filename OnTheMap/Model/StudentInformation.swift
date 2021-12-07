//
//  StudentInformation.swift
//  OnTheMap
//
//  Created by Ty Hopp on 6/12/21.
//

import Foundation

struct StudentInformation: Codable {
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
        case createdAt, firstName, lastName, latitude, longitude, mapString, mediaURL, objectId, uniqueKey, updatedAt
    }
}
