//
//  JsonParser.swift
//  Pods
//
//  Created by COCOMSYS One on 6/29/17.
//
//


import SwiftyJSON

public class JsonParser {
    
    public static func parseRootResponse(json: JSON?) -> JSON? {
        return json?["data"]
    }
    
    public static func parseResponse(response: Any) -> JSON? {
        return JSON(response)
    }
    
    public static func parseList<TModel>(list jsonList: JSON?, parse parseHandler: (JSON?) -> TModel?) -> [TModel]? {
        guard let jsonList = jsonList else {
            return nil
        }
        
        var list = [TModel]()
        
        for (_, elem) in jsonList {
            if let parsedElem = parseHandler(elem) {
                list.append(parsedElem)
            }
        }
        
        return list
    }
}
