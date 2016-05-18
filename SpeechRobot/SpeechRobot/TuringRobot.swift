//
//  TulingRobot.swift
//  SpeechRobot
//
//  Created by 李茂琦 on 5/17/16.
//  Copyright © 2016 Li Maoqi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class TuringRobot {
    
    class ResponseData {
        var text = ""
        var url = ""
        var article = ""
        var icon = ""
        var detailurl = ""
    }
    
    var userQuery = ["key": "cee54e1c065f98fca96054d0586ebb88",
                     "info": ""]
    
    var responseData = ResponseData()
    
    init() {
        Alamofire.request(.POST, "hhtp://www.tuling123.com/openapi/api")
    }
    
    func getTheUserWords(userWords: String) {
        userQuery["info"] = userWords
        self.handleTheRequest()
    }
    
    func handleTheRequest() {
        
        Alamofire.request(.POST, "http://www.tuling123.com/openapi/api", parameters: userQuery, encoding: .JSON).validate().responseJSON { response in
            if let resultValue = response.result.value {
                let json = JSON(resultValue)
                print(json)
                self.handle(json)
            }
        }
        
    }
    
    func handle(json: JSON) {
        if let text = json["text"].string {
            responseData.text = text
        }
        if let url = json["url"].string {
            responseData.url = url
        }
        
        let info = json["list"][0]
        if info != JSON.null {
            if let article = info["article"].string {
                responseData.article = article
            }
            if let icon = info["icon"].string {
                responseData.icon = icon
            }
            if let detailurl = info["detailurl"].string {
                responseData.detailurl = detailurl
            }
        }
    }
    
    func getTheData() -> ResponseData {
        return responseData
    }
    
}
