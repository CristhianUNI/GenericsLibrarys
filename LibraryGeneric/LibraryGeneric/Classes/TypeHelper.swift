//
//  TypeHelper.swift
//  Pods
//
//  Created by COCOMSYS One on 6/29/17.
//
//

import Foundation

public class TypeHelper {
    
    public static func random(max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max)))
    }
    
}

