//
//  Date+UFCFormat.swift
//  Pods
//
//  Created by Marcelo Reina on 15/01/17.
//
//

import Foundation

extension Date {
    /// Constant with date formtar used on all github JSON objects
    fileprivate static var UFCDateFormat: String {
        //2015-07-09T00:00:00Z
        return "yyyy-MM-dd'T'HH:mm:ssZ"
    }
    
    /// Create a Date object based on a string
    ///
    /// - Parameter string: string date with github date string format
    /// - Returns: Date object or nil if it couldn't make the conversion
    static func makeDate(from string: String?) -> Date? {
        guard string != nil else {
            return nil
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = UFCDateFormat
        return formatter.date(from: string!)
    }
    
    /// Printable string based on Date and date style
    ///
    /// - Parameters:
    ///   - date: Date object to be converted to string
    ///   - dateStyle: DateFormatter.Style to convert
    /// - Returns: printable string
    static func makeString(from date: Date, dateStyle: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        return formatter.string(from: date)
    }

}
