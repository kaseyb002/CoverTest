//
//  WineAPI.swift
//  Template
//
//  Created by Kasey Baughan on 5/22/17.
//  Copyright © 2017 Kasey Baughan. All rights reserved.
//

import Foundation
import Alamofire

class WineAPI {
    
    class func getWines(callback: @escaping ([Wine]?, Error?) -> ()) {
        Alamofire.request("https://lcboapi.com/products?q=wine",
                          method: .get,
                          headers: authHeader(token: token)).responseJSON { response in
                            //response.printEverything()
                            guard response.result.isSuccess else {
                                //callback([Order]())
                                callback(nil, response.result.error)
                                return
                            }
                            callback(makeWines(json: response.result.value), nil)
        }
        
    }
    
    class func makeWines(json: Any) -> [Wine]? {
        guard let json = json as? [String:Any] else {return nil}
        guard let winesJson = json["result"] as? [[String:Any]] else {
            print("Wines JSON decode failed")
            return nil
        }
        return winesJson.flatMap(){Wine(json: $0)}
    }
    
}
