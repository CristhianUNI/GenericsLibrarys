//
//  Parcelable.swift
//  Pods
//
//  Created by COCOMSYS One on 6/29/17.
//
//

import SwiftyJSON

protocol Parcelable {
    associatedtype TModel
    func parse(data: JSON?) -> TModel?
}

extension Parcelable {
    
    func parseRootResponse(json: JSON?) -> JSON? {
        return JsonParser.parseRootResponse(json: json)
    }
    
    func parseList(list jsonList: JSON?) -> [TModel]? {
        return JsonParser.parseList(list: jsonList, parse: self.parse)
    }
    
}
