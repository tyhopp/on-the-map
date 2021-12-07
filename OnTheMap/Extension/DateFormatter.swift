//
//  DateFormatter.swift
//  OnTheMap
//
//  Created by Ty Hopp on 7/12/21.
//

import Foundation

extension ISO8601DateFormatter {
    convenience init(_ formatOptions: Options) {
        self.init()
        self.formatOptions = formatOptions
    }
}

extension Formatter {
    static let iso8601 = ISO8601DateFormatter([.withInternetDateTime, .withFractionalSeconds])
}

extension Date {
    var iso8601: String { return Formatter.iso8601.string(from: self) }
}
