//
//  TulingRobot.swift
//  SpeechRobot
//
//  Created by 李茂琦 on 5/17/16.
//  Copyright © 2016 Li Maoqi. All rights reserved.
//

import Foundation
import Alamofire

class TuringRobot {
    
    struct ResponseData {
        var text = ""
        var url = ""
        var article = ""
        var icon = ""
        var detailurl = ""
    }
    
    var jsonHandle = HandleJson()
    
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
                self.responseData = self.jsonHandle.handleTheRobotData(resultValue)
            }
        }
        
    }
    
    func getTheData() -> ResponseData {
        return responseData
    }
    
}
