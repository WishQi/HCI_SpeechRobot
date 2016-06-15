//
//  Login.swift
//  SpeechRobot
//
//  Created by 李茂琦 on 6/14/16.
//  Copyright © 2016 Li Maoqi. All rights reserved.
//

import UIKit

class EnterViewController: UIViewController {
    
    var firstMessageLabel: UILabel!
    var secondMessageLabel: UILabel!
    var thirdMessageLabel: UILabel!
    
    var background: UIImageView!
    
    var enterButton: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        background.center = self.view.center
        
        firstMessageLabel.center.x = self.view.center.x
        firstMessageLabel.center.y = -80
        
        secondMessageLabel.center.x = self.view.center.x - self.view.frame.width
        secondMessageLabel.center.y = self.view.center.y - 60
        
        thirdMessageLabel.center.x = self.view.center.x + self.view.frame.width
        thirdMessageLabel.center.y = secondMessageLabel.center.y + 100
        
        enterButton.center.x = self.view.center.x
        enterButton.center.y = self.view.center.y + self.view.frame.height
    }
    
    func enter() {
        performSegueWithIdentifier("enter", sender: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animateWithDuration(1, delay: 0, options: .AllowUserInteraction, animations: { 
            self.firstMessageLabel.center.y = self.secondMessageLabel.center.y - 100
            }, completion: nil)
        
        UIView.animateWithDuration(1, delay: 2, options: .AllowUserInteraction, animations: { 
            self.secondMessageLabel.center.x += self.view.frame.width
            }, completion: nil)
        
        UIView.animateWithDuration(1, delay: 4, options: .AllowUserInteraction, animations: { 
            self.thirdMessageLabel.center.x -= self.view.frame.width
            }, completion: nil)
        
        UIView.animateWithDuration(1, delay: 6, options: .AllowUserInteraction, animations: { 
            self.enterButton.center.y = self.thirdMessageLabel.center.y + 100
            }, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImage(named: "enterBackground")
        background = UIImageView(image: backgroundImage)
        super.view.addSubview(background)
        
        firstMessageLabel = UILabel()
        firstMessageLabel.textAlignment = .Center
        firstMessageLabel.text = "这里是图灵机器人聊天室！"
        firstMessageLabel.textColor = UIColor.blackColor()
        firstMessageLabel.font = UIFont.systemFontOfSize(20)
        firstMessageLabel.bounds = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
        super.view.addSubview(firstMessageLabel)
        
        secondMessageLabel = UILabel()
        secondMessageLabel.textAlignment = .Center
        secondMessageLabel.text = "在这里你可以和图灵机器人对话！"
        secondMessageLabel.font = UIFont.systemFontOfSize(20)
        secondMessageLabel.textColor = UIColor.blackColor()
        secondMessageLabel.bounds = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
        super.view.addSubview(secondMessageLabel)

        thirdMessageLabel = UILabel()
        thirdMessageLabel.textAlignment = .Center
        thirdMessageLabel.text = "虽然我很傻，但是我很温柔~"
        thirdMessageLabel.font = UIFont.systemFontOfSize(20)
        thirdMessageLabel.textColor = UIColor.blackColor()
        thirdMessageLabel.bounds = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
        super.view.addSubview(thirdMessageLabel)

        enterButton = UIButton()
        enterButton.setTitle("进入", forState: .Normal)
        enterButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        enterButton.layer.borderColor = UIColor.blackColor().CGColor
        enterButton.layer.borderWidth = 1.5
        enterButton.layer.cornerRadius = 15
        enterButton.bounds = CGRect(x: 0, y: 0, width: self.view.frame.width - 80, height: 50)
        enterButton.addTarget(self, action: #selector(enter), forControlEvents: .TouchUpInside)
        super.view.addSubview(enterButton)

    }
    
    
}