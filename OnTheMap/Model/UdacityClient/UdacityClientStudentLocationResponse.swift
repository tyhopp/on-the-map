//
//  UdacityClientStudentLocationResponse.swift
//  OnTheMap
//
//  Created by Ty Hopp on 3/12/21.
//

import Foundation

struct UdacityClientStudentLocationResponse: Codable {
    let results: [StudentInformation]
}
