//
//  TulingRobot.swift
//  SpeechRobot
//
//  Created by 李茂琦 on 5/17/16.
//  Copyright © 2016 Li Maoqi. All rights reserved.
//

import Foundation
import Alamofire


protocol TuringRobotDelegate: class {
    func updateResponseData()
    func updateUI()
}

class TuringRobot {
    
    struct ResponseData {
        var text = ""
        var url = ""
        var article = ""
        var icon = ""
        var detailurl = ""
    }
    
    var responseData = ResponseData()
    
    var jsonHandle = HandleJson()
    
    weak var delegate: TuringRobotDelegate?
    
    var userQuery = ["key": "cee54e1c065f98fca96054d0586ebb88",
                     "info": ""]
    
    
    
    func getTheUserWords(userWords: String) {
        userQuery["info"] = userWords
        handleTheRequest()
    }
    
    func handleTheRequest() {
        
        Alamofire.request(.POST, "http://www.tuling123.com/openapi/api", parameters: userQuery, encoding: .JSON).validate().responseJSON { response in
            if let resultValue = response.result.value {
                self.responseData = self.jsonHandle.handleTheRobotData(resultValue)
                self.delegate?.updateResponseData()
                self.delegate?.updateUI()
                
            }
        }
        
    }
    
    func getTheData() -> ResponseData {
        return responseData
    }
    
}
