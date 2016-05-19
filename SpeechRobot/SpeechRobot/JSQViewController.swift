//
//  JSQViewController.swift
//  SpeechRobot
//
//  Created by 李茂琦 on 5/19/16.
//  Copyright © 2016 Li Maoqi. All rights reserved.
//

import Foundation
import JSQMessagesViewController

class JSQViewController: JSQMessagesViewController {
    
    var messages = [JSQMessage]()
    var message: JSQMessage!
    
    var messageBubble: JSQMessagesBubbleImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        senderId = "729981607"
        senderDisplayName = "Limaoqi"
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didPressAccessoryButton(sender: UIButton!) {
        print("press the accessory button")
    }
    
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        message = JSQMessage.init(senderId: senderId, displayName: senderDisplayName, text: text)
        print(message)
        messages.append(message)
        let indexPath = NSIndexPath(forRow: messages.count - 1, inSection: 0)
        let indexPaths = [indexPath]
        collectionView.insertItemsAtIndexPaths(indexPaths)
        finishSendingMessage()
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> JSQMessagesCollectionViewCell {
        
        let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath) as! JSQMessagesCollectionViewCell
        
        cell.backgroundColor = UIColor.clearColor()
        
        cell.textView.textColor = UIColor.blackColor()
        
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
