//
//  HttpManager.swift
//  Pods
//
//  Created by COCOMSYS One on 6/29/17.
//
//

import Foundation
import Alamofire
import SwiftyJSON
import PromiseKit
import ResponseDetective

class HttpManager {
    
    var defaultHeaders: [String: String]?
    var onParsedHandler: ((JSON?) -> JSON?)?
    
    init(headers: [String: String]? = nil, onParsedHandler: ((JSON?) -> JSON?)? = nil) {
        self.defaultHeaders = headers
        self.onParsedHandler   = onParsedHandler
        
    }
    
    let sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        ResponseDetective.enable(inConfiguration: configuration)
        return SessionManager(configuration: configuration)
    }()
    
    func request<TResponse>(
        verb: HTTPMethod,
        url: String,
        parameters: [String: AnyObject]? = nil,
        headers: [String: String]? = nil,
        encoding: ParameterEncoding = JSONEncoding.default ,
        parse parseHandler: @escaping (JSON?) -> TResponse) -> Promise<TResponse> {
        
        return Promise { fulfill, reject in
            sessionManager.request(url,
                                   method: verb,
                                   parameters: parameters,
                                   encoding: encoding,
                                   headers: headers)
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .success(let data):
                        var json = JsonParser.parseResponse(response: data)
                        if let parsedHandler = self.onParsedHandler {
                            json = parsedHandler(json)
                        }
                        let parsedResponse = parseHandler(json)
                        fulfill(parsedResponse)
                    case .failure(let error):
                        reject(error)
                    }
            }
        }
    }
    
}

