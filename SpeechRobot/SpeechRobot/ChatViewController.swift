//
//  ViewController.swift
//  SpeechRobot
//
//  Created by 李茂琦 on 5/16/16.
//  Copyright © 2016 Li Maoqi. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, IFlySpeechRecognizerDelegate, IFlySpeechSynthesizerDelegate, TuringRobotDelegate {
    
    var iflySpeechRecognizer = IFlySpeechRecognizer()
    var iflySpeechSynthesizer = IFlySpeechSynthesizer()
    
    var superView = UIView()
    
    var beginSpeakingButton = UIButton()
    var stopSpeakingButton = UIButton()
    
    var recognizeResultsTextView = UITextView()
    var responseResultsTextView = UITextView()
    
    var recognizedResults = ""
    var speechRobotWords = ""
    
    let turingRobot = TuringRobot()
    let jsonHandle = HandleJson()
    
    var responseData = TuringRobot.ResponseData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        superView = self.view
        
        turingRobot.delegate = self
        
        configureUI()
        
        configureSpeechRecognizer()
        configureSpeechSynthesizer()
        
        realizeButtons()
    }
    
    func configureUI() {
        
        superView.addSubview(beginSpeakingButton)
        beginSpeakingButton.frame.size = CGSize(width: 200, height: 100)
        beginSpeakingButton.center = superView.center
        beginSpeakingButton.setTitle("Begin Speaking", forState: .Normal)
        beginSpeakingButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        beginSpeakingButton.layer.borderWidth = CGFloat(3)
        beginSpeakingButton.layer.borderColor = UIColor.blackColor().CGColor
        beginSpeakingButton.layer.cornerRadius = 10
        
        superView.addSubview(stopSpeakingButton)
        stopSpeakingButton.frame.size = CGSize(width: 200, height: 100)
        stopSpeakingButton.frame.origin.y = beginSpeakingButton.frame.maxY + 10
        stopSpeakingButton.center.x = superView.center.x
        stopSpeakingButton.setTitle("Stop Speaking", forState: .Normal)
        stopSpeakingButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        stopSpeakingButton.layer.borderWidth = CGFloat(3)
        stopSpeakingButton.layer.borderColor = UIColor.blackColor().CGColor
        stopSpeakingButton.layer.cornerRadius = 10
        
        superView.addSubview(recognizeResultsTextView)
        recognizeResultsTextView.frame.size = CGSize(width: 200, height: 100)
        recognizeResultsTextView.frame.origin.y = stopSpeakingButton.frame.maxY + 10
        recognizeResultsTextView.center.x = superView.center.x
        recognizeResultsTextView.backgroundColor = UIColor.clearColor()
        recognizeResultsTextView.textColor = UIColor.blackColor()
        recognizeResultsTextView.layer.cornerRadius = 10
        recognizeResultsTextView.layer.borderColor = UIColor.blackColor().CGColor
        recognizeResultsTextView.layer.borderWidth = CGFloat(3)
        
        superView.addSubview(responseResultsTextView)
        responseResultsTextView.frame.size = CGSize(width: 200, height: 100)
        responseResultsTextView.center.y = superView.center.y - 120
        responseResultsTextView.center.x = superView.center.x
        responseResultsTextView.backgroundColor = UIColor.clearColor()
        responseResultsTextView.textColor = UIColor.blackColor()
        responseResultsTextView.layer.cornerRadius = 10
        responseResultsTextView.layer.borderColor = UIColor.blackColor().CGColor
        responseResultsTextView.layer.borderWidth = CGFloat(3)
    }
    
    func realizeButtons() {
        beginSpeakingButton.addTarget(self, action: #selector(pressTheStartButton), forControlEvents: .TouchUpInside)
        stopSpeakingButton.addTarget(self, action: #selector(pressTheStopButton), forControlEvents: .TouchUpInside)
    }
    
    func pressTheStartButton() {
        iflySpeechRecognizer.startListening()
    }
    
    func pressTheStopButton() {
        iflySpeechRecognizer.stopListening()
    }
    
    func configureSpeechRecognizer() {
        iflySpeechRecognizer = IFlySpeechRecognizer.sharedInstance()
        iflySpeechRecognizer.delegate = self
        iflySpeechRecognizer.setParameter("iat", forKey: IFlySpeechConstant.IFLY_DOMAIN())
        iflySpeechRecognizer.setParameter("asrview.pcm", forKey: "/Users/limaoqi/Documents/用户交互技术/Voices")
    }
    
    func configureSpeechSynthesizer() {
        iflySpeechSynthesizer = IFlySpeechSynthesizer.sharedInstance()
        iflySpeechSynthesizer.delegate = self
        iflySpeechSynthesizer.setParameter(IFlySpeechConstant.TYPE_CLOUD(), forKey: IFlySpeechConstant.ENGINE_TYPE())
        iflySpeechSynthesizer.setParameter("50", forKey: IFlySpeechConstant.VOLUME())
        iflySpeechSynthesizer.setParameter("LiMaoqi", forKey: IFlySpeechConstant.VOICE_NAME())
        iflySpeechSynthesizer.setParameter("tts.pcm", forKey: "/Users/limaoqi/Documents/用户技术/Voices")
    }
    
    
    //SpeechRobot的delegate的函数
    func updateUIAndData() {
        responseData = turingRobot.getTheData()
        if responseData.text != "" {
            speechRobotWords = responseData.text
        }
        if responseData.url != "" {
            speechRobotWords += responseData.url
        }
        if responseData.article != "" {
            speechRobotWords += "\n\(responseData.article)"
        }
        if responseData.icon != "" {
            speechRobotWords += responseData.icon
        }
        if responseData.detailurl != "" {
            speechRobotWords += responseData.detailurl
        }
        responseResultsTextView.text = speechRobotWords
        recognizedResults = ""
        iflySpeechSynthesizer.startSpeaking(speechRobotWords)
    }
    
    
    func sendTheUserWordsToTuringRobot() {
        turingRobot.getTheUserWords(recognizedResults)
    }
    
    //IFlySpeechRecognizerDelegate 识别代理
    func onResults(results: [AnyObject]!, isLast: Bool) {
        print("xixi")
        if results != nil {
            recognizedResults = jsonHandle.handleTheUserWords(results, previous: recognizedResults)
        }
        if isLast {
            sendTheUserWordsToTuringRobot()
            recognizeResultsTextView.text = recognizedResults
        }
    }
    
    func onEndOfSpeech() {
        print("xixi")
    }
    
    func onError(errorCode: IFlySpeechError!) {
    }

    func onCompleted(error: IFlySpeechError!) {
    }

}

