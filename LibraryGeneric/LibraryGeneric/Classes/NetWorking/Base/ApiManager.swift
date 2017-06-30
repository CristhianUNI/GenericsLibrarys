//
//  ApiManager.swift
//  Pods
//
//  Created by COCOMSYS One on 6/29/17.
//
//

import Foundation

public class ApiManager {
    
    public static let sharedInstance = ApiManager()
    
    public var authToken: String?
    public var http: HttpManager
    
    public init() {
        http = HttpManager()
        http.onParsedHandler = JsonParser.parseRootResponse
    }
    
}
