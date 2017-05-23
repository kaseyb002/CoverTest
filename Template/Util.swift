//
//  Util.swift
//  Template
//
//  Created by Kasey Baughan on 5/22/17.
//  Copyright © 2017 Kasey Baughan. All rights reserved.
//

import Foundation
import Alamofire

extension Double {

    var currency: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        //        formatter.locale = NSLocale(localeIdentifier: "es_CL")
        let full = formatter.string(from: self as NSNumber)!
        let truncated = full.substring(to: full.characters.index(full.endIndex, offsetBy: -3))
        return self.truncatingRemainder(dividingBy: 1) == 0 ? truncated : full
    }

}

let token = "MDpmNjlmMGI2Mi0zZjMzLTExZTctYjAxZi0zNzdiOWFiZmFiZTE6SnJxd0RKdHJIWWtSd2YzVXptam4wN3I2dFZDOGtZa05XV215"
func authHeader(token: String) -> HTTPHeaders {
    return ["Authorization":"Token \(token)"]
}
