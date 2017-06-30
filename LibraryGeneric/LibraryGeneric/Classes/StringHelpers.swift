//
//  StringHelpers.swift
//  Pods
//
//  Created by COCOMSYS One on 6/29/17.
//
//

import Foundation

public enum HelperError: Error {
    case InvalidConversion(String)
}

public class StringHelper {
    
    public static func toDouble(str: String) throws -> Double {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        guard let numbVal = formatter.number(from: str) else {
            throw HelperError.InvalidConversion("Something went wrong parsing value") //TODO: localize
        }
        return numbVal.doubleValue
    }
    
    public static func truncate(str: String, length: Int, trailing: String? = "...") -> String {
        if hasToTruncate(str: str, length: length) {
            return str.substring(to: str.startIndex.advance(length, string: str)) + (trailing ?? "")
            
        } else {
            return str
        }
    }
    
    public static func hasToTruncate(str: String, length: Int) -> Bool {
        return str.characters.count > length
    }
    
}

