//
//  Wine.swift
//  Template
//
//  Created by Kasey Baughan on 5/22/17.
//  Copyright © 2017 Kasey Baughan. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

struct Wine {
    var name: String
    var description: String?
    var price: Double
    var oz: String
    var imageUrl: String
    var alcoholContent: Double
    var producerName: String
    var origin: String
    var releasedOn: Date?
    var sugarInGramsPerLiter: Double?
    var sugarContent: String?
}

extension Wine {
    
    init?(json: Any) {
        guard let json = json as? [String:Any] else {return nil}
        guard let name = json["name"] as? String,
            let priceInCents = json["price_in_cents"] as? Double,
            let imageUrl = json["image_url"] as? String,
            let oz = json["package"] as? String,
            let origin = json["origin"] as? String,
            let producerName = json["producer_name"] as? String,
            let alcoholContent = json["alcohol_content"] as? Double
            else {
                print("Wine JSON decode failed")
                return nil
        }
        self.name = name
        self.price = priceInCents / 100
        self.imageUrl = imageUrl
        self.description = json["description"] as? String
        self.oz = oz
        self.origin = origin
        self.producerName = producerName
        self.alcoholContent = alcoholContent / 100
        if let releasedOnString = json["released_on"] as? String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-DD"
            self.releasedOn = dateFormatter.date(from: releasedOnString)
        }
        self.sugarInGramsPerLiter = json["sugar_in_grams_per_liter"] as? Double
        self.sugarContent = json["sugar_content"] as? String
    }
    
}

extension Wine {
    
    //returns a list of all the product attributes
    //key is product label name
    //value is attribute content
    //e.g., Made in: France
    //key = "Made in"
    //value = "France"
    var attributeList: [String:String] {
        var attributes = [String:String]()
        attributes["Made in"] = origin
        attributes["By"] = producerName
        if let sugarContent = sugarContent {
            attributes["Sugar Description"] = sugarContent
        }
        if let sugarInGramsPerLiter = sugarInGramsPerLiter {
            attributes["Sugar Grams per Liter"] = "\(sugarInGramsPerLiter) grams"
        }
        return attributes
    }
    
    func getImage(callback: @escaping (UIImage?, Error?) -> ()) {
        Alamofire.request(imageUrl).responseImage { response in
            if let image = response.result.value {
                callback(image, nil)
            } else {
                callback(nil, response.result.error)
            }
        }
    }
    
}
