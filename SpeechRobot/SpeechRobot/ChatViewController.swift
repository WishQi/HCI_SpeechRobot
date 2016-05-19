//
//  ViewController.swift
//  SpeechRobot
//
//  Created by 李茂琦 on 5/16/16.
//  Copyright © 2016 Li Maoqi. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class ChatViewController: JSQMessagesViewController, IFlySpeechRecognizerDelegate, IFlySpeechSynthesizerDelegate, TuringRobotDelegate {
    
    var iflySpeechRecognizer = IFlySpeechRecognizer()
    var iflySpeechSynthesizer = IFlySpeechSynthesizer()
    
    var superView = UIView()
    
    var backgroundImageView: UIImageView!
    
    var beginSpeakingButton = UIButton()
    var stopSpeakingButton = UIButton()
    
    var recognizedResults = ""
    var speechRobotWords = ""
    
    let turingRobot = TuringRobot()
    let jsonHandle = HandleJson()
    
    var messages = [JSQMessage]()
    
    var responseData = TuringRobot.ResponseData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        superView = self.view
        
        let background = UIImage(named: "1.pic")
        backgroundImageView = UIImageView(image: background)
        superView.addSubview(backgroundImageView)
        self.view.sendSubviewToBack(backgroundImageView)
        collectionView.backgroundColor = UIColor.clearColor()
        self.view.backgroundColor = UIColor.clearColor()
        
        turingRobot.delegate = self
        
        senderId = "729981607"
        senderDisplayName = "Limaoqi"
        
        configureSpeechRecognizer()
        configureSpeechSynthesizer()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didPressAccessoryButton(sender: UIButton!) {
        pressTheStartButton()
    }
    
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        
        let message = JSQMessage.init(senderId: senderId, displayName: senderDisplayName, text: text)
        
        recognizedResults = text
        
        sendTheUserWordsToTuringRobot()
        
        messages.append(message)
        
        let indexPath = NSIndexPath(forRow: messages.count - 1, inSection: 0)
        let indexPaths = [indexPath]
        collectionView.insertItemsAtIndexPaths(indexPaths)
        finishSendingMessage()
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
        recognizedResults = ""
        
        updateMessage(speechRobotWords)

        iflySpeechSynthesizer.startSpeaking(responseData.text)
    }
    
    func updateMessage(text: String) {
        let message = JSQMessage.init(senderId: senderId, displayName: senderDisplayName, text: text)
        messages.append(message)
        
        let indexPath = NSIndexPath(forRow: messages.count - 1, inSection: 0)
        let indexPaths = [indexPath]
        collectionView.insertItemsAtIndexPaths(indexPaths)
        finishSendingMessage()
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
            updateMessage(recognizedResults)
            sendTheUserWordsToTuringRobot()
        }
    }
    
    func onEndOfSpeech() {
        print("xixi")
    }
    
    func onError(errorCode: IFlySpeechError!) {
    }

    func onCompleted(error: IFlySpeechError!) {
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> JSQMessagesCollectionViewCell {
        
        let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath) as! JSQMessagesCollectionViewCell
        
        cell.backgroundColor = UIColor.clearColor()
        
        cell.textView.textColor = UIColor.whiteColor()
        
        print(cell.reuseIdentifier)
        
        return cell
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        return messages[indexPath.row]
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        return nil
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, didDeleteMessageAtIndexPath indexPath: NSIndexPath!) {
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }

}

