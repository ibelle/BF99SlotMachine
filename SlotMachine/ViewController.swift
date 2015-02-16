//
//  ViewController.swift
//  SlotMachine
//
//  Created by HUGE | Isaiah Belle on 2/14/15.
//  Copyright (c) 2015 IsaiahBelleDigital. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var firstContainer: UIView!
    var secondContainer: UIView!
    var thirdContainer: UIView!
    var fourthContainer: UIView!
    var titleLabel:UILabel!
    
    let kMyYellow:UIColor = UIColor(red: 248.0/255.0, green: 218.0/255.0, blue: 49.0/255.0 , alpha: 1.0)
    let kMyRed:UIColor = UIColor(red: 166.0/255.0, green: 51.0/255.0, blue: 46.0/255.0 , alpha: 1.0)
    let kMyGreen:UIColor =  UIColor(red: 106.0/255.0, green: 187.0/255.0, blue: 103.0/255.0 , alpha: 1.0)
    let kMyGold:UIColor = UIColor(red: 221.0/255.0, green: 209.0/255.0, blue: 9.0/255.0 , alpha: 1.0)

    
    let kMarginForView:CGFloat=10.0 //Margin for left and right of view
    let kMarginForSlot:CGFloat = 2.0

    let kNumberOfContainers = 3
    let kNumberOfSlots = 3
    
    //Scalars for view height e.g. 1/6th hieght of container view etc.
    let kThird: CGFloat = 1.0/3.0
    let kSixth:CGFloat = 1.0/6.0
    let kHalf:CGFloat = 1.0/2.0
    let kEighth:CGFloat = 1.0/8.0
    
    //Information Labels
    var creditsLabel:UILabel!
    var betLabel:UILabel!
    var winnerPaidLabel:UILabel!
    
    //Title Labels
    var creditsTitleLabel:UILabel!
    var betTitleLabel:UILabel!
    var winnerPaidTitleLabel:UILabel!
    
    //Buttons
    var restButton: UIButton!
    var bet1Button:UIButton!
    var betMaxButton:UIButton!
    var spinButton: UIButton!
    
    // Slots Array
    var slots: [[Slot]] = []
    
    //Stats
    var credits = 0
    var currentBet = 0
    var winnings = 0
    let kMaxBet = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setUpContainerViews()
        setUpFirstContainer()
        setUpThirdContainer()
        setUpForthContainer()
        hardReset()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //IBActions
    func resetButtonPressed(button: UIButton){
        hardReset()
    }
   
    func bet1ButtonPressed(button: UIButton){
      
        if credits <= 0 {
                showAlertWithText(header: "No More Credits", message: "Reset Game", handler: nil, completion: nil)
        }else{
            
            if currentBet < kMaxBet{
                currentBet+=1
                credits-=1
                winnings = 0
                updateMainView()
            }else{
                showAlertWithText(message: "You Can only bet \(kMaxBet) credits at a time", handler: nil, completion: nil)
            }
            
        }
        
    }
  
    func betMaxButtonPressed(button: UIButton){
        
        if credits <= 5 {
            showAlertWithText(header: "Not Enough Credits", message: "Bet Less", handler: nil, completion: nil)
        }else{
            
            if currentBet < kMaxBet{
               var creditsToBetMax = kMaxBet - currentBet
                
                credits -= creditsToBetMax
                currentBet += creditsToBetMax
                winnings = 0
                updateMainView()
            }else{
                showAlertWithText(message: "You Can only bet \(kMaxBet) credits at a time", handler: nil, completion: nil)
            }
            
        }
        
    }
    
    func spinButtonPressed(button: UIButton){
        if currentBet == 0 {
            showAlertWithText(header: "No Wager", message: "Please Make a Bet")
            return
        }
        slots = SlotFactory.createSlots()
        setUpSecondContainer()
        
        var winningsMultiplier = SlotManager.computeWinnings(slots)
        winnings = winningsMultiplier * currentBet
        credits += winnings
        currentBet = 0
        updateMainView()
    }
    
 
    func setUpContainerViews(){
        //First SubView
       self.firstContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x + kMarginForView, y: self.view.bounds.origin.y, width: self.view.bounds.width - (kMarginForView * 2), height: self.view.bounds.height * kSixth))
        self.firstContainer.backgroundColor = UIColor.redColor()
        self.view.addSubview(self.firstContainer)
        
        //Second SubView
        self.secondContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x + kMarginForView, y: firstContainer.frame.height, width: self.view.bounds.width - (kMarginForView * 2), height: self.view.bounds.height * (3 * kSixth)))
        self.secondContainer.backgroundColor = UIColor.blackColor()
        self.view.addSubview(self.secondContainer)
        
        
        //Third SubView
        self.thirdContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x + kMarginForView, y: secondContainer.frame.maxY, width: self.view.bounds.width - (kMarginForView * 2), height: self.view.bounds.height * kSixth))
        self.thirdContainer.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(self.thirdContainer)
        
        //Forth SubView
        self.fourthContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x + kMarginForView, y: thirdContainer.frame.maxY, width: self.view.bounds.width - (kMarginForView * 2), height: self.view.bounds.height * kSixth))
        self.fourthContainer.backgroundColor = UIColor.blackColor()
        self.view.addSubview(self.fourthContainer)
    }
    func setUpFirstContainer(){
        self.titleLabel = UILabel()
        self.titleLabel.text = "Mega Bucks Slots!!"
        self.titleLabel.textColor = kMyYellow
        self.titleLabel.font = UIFont(name: "MarkerFelt-Wide", size: 40)
        self.titleLabel.sizeToFit()
        self.titleLabel.center = self.firstContainer.center
        self.firstContainer.addSubview(titleLabel)
    }
    func setUpSecondContainer(){
        self.removeSlotImageViews()
        for var containerNumber = 0 ; containerNumber < kNumberOfContainers; containerNumber++ {
            for var slotNumber = 0 ; slotNumber < kNumberOfSlots; slotNumber++ {
                var slot:Slot
                var slotImageView = UIImageView()
                
                if slots.count != 0 {
                    let slotContainer = slots[containerNumber]
                    slot = slotContainer[slotNumber]
                    slotImageView.image = slot.image
                }else{
                    slotImageView.image = UIImage(named: "Ace")
                }
                
                slotImageView.backgroundColor = kMyYellow //UIColor.yellowColor()
                //Use slot/container number and containerview bounds to layout these imageviews
             slotImageView.frame = CGRect(x: secondContainer.bounds.origin.x + (secondContainer.bounds.size.width * CGFloat(containerNumber) * kThird), y: secondContainer.bounds.origin.y + (secondContainer.bounds.size.height * CGFloat(slotNumber) * kThird), width: secondContainer.bounds.width * kThird - kMarginForSlot, height: secondContainer.bounds.height * kThird - kMarginForSlot)
                self.secondContainer.addSubview(slotImageView)
                }
            }
    }
    
    func setUpThirdContainer(){
        self.creditsLabel = UILabel()
        self.creditsLabel.text = "000000"
        self.creditsLabel.textColor = kMyGold
        self.creditsLabel.font = UIFont(name: "Menlo-Bold", size: 16)
        self.creditsLabel.sizeToFit()
        self.creditsLabel.center = CGPoint(x: thirdContainer.frame.width * kSixth, y: thirdContainer.frame.height * kThird)
        self.creditsLabel.textAlignment = NSTextAlignment.Center
        self.creditsLabel.backgroundColor = UIColor.darkGrayColor()
        self.thirdContainer.addSubview(self.creditsLabel)
        
        self.betLabel = UILabel()
        self.betLabel.text = "0000"
        self.betLabel.textColor = kMyGold
        self.betLabel.font = UIFont(name: "Menlo-Bold", size: 16)
        self.betLabel.sizeToFit()
        self.betLabel.center = CGPoint(x: thirdContainer.frame.width * kSixth * 3, y: thirdContainer.frame.height * kThird)
        self.betLabel.textAlignment = NSTextAlignment.Center
        self.betLabel.backgroundColor = UIColor.darkGrayColor()
        thirdContainer.addSubview(self.betLabel)
        
        self.winnerPaidLabel = UILabel()
        self.winnerPaidLabel.text = "000000"
        self.winnerPaidLabel.textColor = kMyGold
        self.winnerPaidLabel.font = UIFont(name: "Menlo-Bold", size: 16)
        self.winnerPaidLabel.sizeToFit()
        self.winnerPaidLabel.center = CGPoint(x: thirdContainer.frame.width * kSixth * 5, y: thirdContainer.frame.height * kThird)
        self.winnerPaidLabel.textAlignment = NSTextAlignment.Center
        self.winnerPaidLabel.backgroundColor = UIColor.darkGrayColor()
        thirdContainer.addSubview(self.winnerPaidLabel)
        
        self.creditsTitleLabel = UILabel()
        self.creditsTitleLabel.textColor = UIColor.blackColor()
        self.creditsTitleLabel.text = "Credits"
        self.creditsTitleLabel.font = UIFont(name: "AmericanTypewriter-Bold", size: 14)
        self.creditsTitleLabel.sizeToFit()
        self.creditsTitleLabel.center = CGPoint(x: thirdContainer.frame.width * kSixth, y: thirdContainer.frame.height * kThird * 2)
        self.thirdContainer.addSubview(creditsTitleLabel)
        
        self.betTitleLabel = UILabel()
        self.betTitleLabel.text = "Bet"
        self.betTitleLabel.textColor = UIColor.blackColor()
        self.betTitleLabel.font = UIFont(name: "AmericanTypewriter-Bold", size: 14)
        self.betTitleLabel.sizeToFit()
        self.betTitleLabel.center = CGPoint(x: thirdContainer.frame.width * kSixth * 3, y: thirdContainer.frame.height * kThird * 2)
        self.thirdContainer.addSubview(betTitleLabel)
        
        
        self.winnerPaidTitleLabel = UILabel()
        self.winnerPaidTitleLabel.text = "Winner Paid"
        self.winnerPaidTitleLabel.font = UIFont(name: "AmericanTypewriter-Bold", size: 14)
        self.winnerPaidTitleLabel.textColor = UIColor.blackColor()
        self.winnerPaidTitleLabel.sizeToFit()
        self.winnerPaidTitleLabel.center = CGPoint(x: thirdContainer.frame.width * kSixth * 5, y: thirdContainer.frame.height * kThird * 2)
        self.thirdContainer.addSubview(winnerPaidTitleLabel)
        
        
        
    }
    
    func setUpForthContainer(){
        self.restButton = UIButton()
        self.restButton.setTitle("Reset", forState: UIControlState.Normal)
        self.restButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.restButton.titleLabel?.font = UIFont(name: "Futura-CondensedExtraBold", size: 12)
        self.restButton.backgroundColor = UIColor.lightGrayColor()
        self.restButton.sizeToFit()
        self.restButton.center = CGPoint(x: self.fourthContainer.frame.width * kEighth, y: self.fourthContainer.frame.height * kHalf)
        self.restButton.addTarget(self, action: "resetButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.fourthContainer.addSubview(restButton)
        
        self.bet1Button = UIButton()
        self.bet1Button.setTitle("Bet Once", forState: UIControlState.Normal)
        self.bet1Button.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.bet1Button.titleLabel?.font =  UIFont(name: "Futura-CondensedExtraBold", size: 12)
        self.bet1Button.backgroundColor = UIColor.greenColor()
        self.bet1Button.sizeToFit()
        //Center button at 3/8ths of the containerViews width and in the vertical center
        self.bet1Button.center = CGPoint(x: fourthContainer.frame.width * 3 * kEighth, y: fourthContainer.frame.height * kHalf)
        self.bet1Button.addTarget(self, action: "bet1ButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.fourthContainer.addSubview(bet1Button)
        
        self.betMaxButton = UIButton()
        self.betMaxButton.setTitle("BetMax", forState: UIControlState.Normal)
        self.betMaxButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.betMaxButton.titleLabel?.font = UIFont(name: "Futura-CondensedExtraBold", size: 12)
        self.betMaxButton.backgroundColor = kMyRed
        self.betMaxButton.sizeToFit()
        self.betMaxButton.center = CGPoint(x: fourthContainer.frame.width * 5 * kEighth, y: fourthContainer.frame.height * kHalf)
        self.betMaxButton.addTarget(self, action: "betMaxButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.fourthContainer.addSubview(self.betMaxButton)
        
        self.spinButton = UIButton()
        self.spinButton.setTitle("Spin", forState: UIControlState.Normal)
        self.spinButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.spinButton.titleLabel?.font = UIFont(name: "Futura-CondensedExtraBold", size: 12)
        self.spinButton.backgroundColor = kMyGold
        self.spinButton.sizeToFit()
        self.spinButton.center = CGPoint(x: fourthContainer.frame.width * 7 * kEighth, y: fourthContainer.frame.height * kHalf)
        self.spinButton.addTarget(self, action: "spinButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.fourthContainer.addSubview(self.spinButton)
        
    }
    
   
    func removeSlotImageViews(){
        if let container = self.secondContainer {
            
            for view in container.subviews {
                view.removeFromSuperview()
            }
        }
    }
    
    
    func hardReset(){
        removeSlotImageViews()
        slots.removeAll(keepCapacity: true)
        self.setUpSecondContainer()
        credits = 50
        winnings = 0
        currentBet = 0
        updateMainView()
    }
    
    func updateMainView () {
        self.creditsLabel.text = "\(credits)"
        self.betLabel.text = "\(currentBet)"
        self.winnerPaidLabel.text = "\(winnings)"
    }
    
    func showAlertWithText(
        header: String = "Warning",
        message: String,
        handler: ((UIAlertAction!) -> Void)? = nil,
        completion: (() -> Void)? = nil){
            
        var alert  = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: handler))
        self.presentViewController(alert, animated: true, completion: completion)
    }

}

