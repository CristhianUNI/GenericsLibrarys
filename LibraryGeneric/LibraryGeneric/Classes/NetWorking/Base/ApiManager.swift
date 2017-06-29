//
//  ApiManager.swift
//  Pods
//
//  Created by COCOMSYS One on 6/29/17.
//
//

import Foundation

class ApiManager {
    
    public static let sharedInstance = ApiManager()
    
    var authToken: String?
    var http: HttpManager
    
    init() {
        http = HttpManager()
        http.onParsedHandler = JsonParser.parseRootResponse
    }
    
}
