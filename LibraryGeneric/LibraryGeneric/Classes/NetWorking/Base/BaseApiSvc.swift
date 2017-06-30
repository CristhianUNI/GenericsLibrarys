//
//  BaseApiSvc.swift
//  Pods
//
//  Created by COCOMSYS One on 6/29/17.
//
//

import Foundation
import SwiftyJSON
import PromiseKit
import Alamofire

public class BaseApiSvc {
    
    
    public func get<TResponse>( verb: HTTPMethod = .get, baseUrl: String, resource: String, parameters: [String: AnyObject]? = nil, headers: [String: String]? = nil , parse parseHandler: @escaping (JSON?) -> TResponse) -> Promise<TResponse> {
        
        return ApiManager.sharedInstance.http.request(verb: verb, url: "\(baseUrl)\(resource)", parameters: parameters, headers: headers, parse: parseHandler)
    }
}
