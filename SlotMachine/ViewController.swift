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
    let kMarginForView:CGFloat=10.0 //Margin for left and right of view
    let kSixth:CGFloat = 1.0/6.0 //scalar for view height e.g. 1/6th hieght of container view
    
    let kNumberOfContainers = 3
    let kNumberOfSlots = 3
    let kThird: CGFloat = 1.0/3.0
    let kMarginForSlot:CGFloat = 2.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUpContainerViews()
        setUpFirstContainer()
        setUpSecondContainer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        self.fourthContainer.backgroundColor = UIColor.blueColor()
        self.view.addSubview(self.fourthContainer)
    }
    func setUpFirstContainer(){
        self.titleLabel = UILabel()
        self.titleLabel.text = "Hit Dem Slots!!"
        self.titleLabel.textColor = kMyYellow
        self.titleLabel.font = UIFont(name: "MarkerFelt-Wide", size: 40)
        self.titleLabel.sizeToFit()
        self.titleLabel.center = self.firstContainer.center
        self.firstContainer.addSubview(titleLabel)
    }
    func setUpSecondContainer(){
        for var containerNumber = 0 ; containerNumber < kNumberOfContainers; containerNumber++ {
            for var slotNumber = 0 ; slotNumber < kNumberOfSlots; slotNumber++ {
                var slotImageView = UIImageView()
                slotImageView.backgroundColor = kMyYellow //UIColor.yellowColor()
                //Use slot/container number and containerview bounds to layout these imageviews
             slotImageView.frame = CGRect(x: secondContainer.bounds.origin.x + (secondContainer.bounds.size.width * CGFloat(containerNumber) * kThird), y: secondContainer.bounds.origin.y + (secondContainer.bounds.size.height * CGFloat(slotNumber) * kThird), width: secondContainer.bounds.width * kThird - kMarginForSlot, height: secondContainer.bounds.height * kThird - kMarginForSlot)
                self.secondContainer.addSubview(slotImageView)
                }
            }
    }

}

