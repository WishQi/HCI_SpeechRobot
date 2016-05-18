//
//  HandleJson.swift
//  SpeechRobot
//
//  Created by 李茂琦 on 5/18/16.
//  Copyright © 2016 Li Maoqi. All rights reserved.
//

import Foundation
import SwiftyJSON

class HandleJson {
    
    func handleTheRobotData(data: AnyObject) -> TuringRobot.ResponseData {
        var robotData = TuringRobot.ResponseData()
        var json = JSON(data)
        print(json)
        if let text = json["text"].string {
            robotData.text = text
        }
        if let url = json["url"].string {
            robotData.url = url
        }
        let info = json["list"][0]
        if info != JSON.null {
            if let article = info["article"].string {
                robotData.article = article
            }
            if let icon = info["icon"].string {
                robotData.icon = icon
            }
            if let detailurl = info["detailurl"].string {
                robotData.detailurl = detailurl
            }
        }
        return robotData
    }
    
    func handleTheUserWords(data :AnyObject, previous: String) -> String {
        var userWords = previous
        if let path = JSON(data)[0].first?.0 {
            if let dataFromString = path.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
                let json = JSON(data: dataFromString)
                print(json)
                let ws = json["ws"]
                for (index, _): (String, JSON) in ws {
                    if let indexOfSubJson = Int(index) {
                        userWords += ws[indexOfSubJson]["cw"][0]["w"].stringValue
                    }
                }
            }
        }
        return userWords
    }
    
}
