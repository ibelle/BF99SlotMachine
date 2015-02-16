//
//  Factory.swift
//  SlotMachine
//
//  Created by HUGE | Isaiah Belle on 2/15/15.
//  Copyright (c) 2015 IsaiahBelleDigital. All rights reserved.
//

import Foundation
import UIKit

class SlotFactory{
    
    
    class func createSlots() -> [[Slot]] {
        var returnedSlots:[[Slot]] = []
        let kNumberOfSlots = 3
        let kNumberOfContainers = 3
        
        for var containerNumber = 0; containerNumber < kNumberOfContainers; containerNumber++ {
            var slotArray:[Slot] = []
            for var slotNumber = 0; slotNumber < kNumberOfSlots; ++slotNumber {
                
                var slot = createSlot(slotArray)
                slotArray.append(slot)
            }
            returnedSlots.append(slotArray)
        }
        return returnedSlots
    }
    
    class func createSlot(currentCards: [Slot]?) -> Slot {//Just to play with Optionals Here also
        var currentCardValues:[Int] = []
        
        if let inputCards = currentCards{
            inputCards.map({ $0.value })//I like this 10x better in this context to a foreach
        }
        
        var randomNumber:Int
        do {
            randomNumber = Int(arc4random_uniform(UInt32(13))) + 1
        } while contains(currentCardValues, randomNumber)
        
        var slot: Slot
        
        switch randomNumber{
        case 1:
            slot = Slot(value: 1, image: UIImage(named: "Ace"), isRed: true)
        case 2:
            slot = Slot(value: 2, image: UIImage(named: "Two"), isRed: true)
        case 3:
            slot = Slot(value: 3, image: UIImage(named: "Three"), isRed: true)
        case 4:
            slot = Slot(value: 4, image: UIImage(named: "Four"), isRed: true)
        case 5:
            slot = Slot(value: 5, image: UIImage(named: "Five"), isRed: false)
        case 6:
            slot = Slot(value: 6, image: UIImage(named: "Six"), isRed: false)
        case 7:
            slot = Slot(value: 7, image: UIImage(named: "Seven"), isRed: true)
        case 8:
            slot = Slot(value: 8, image: UIImage(named: "Eight"), isRed: false)
        case 9:
            slot = Slot(value: 9, image: UIImage(named: "Nine"), isRed: false)
        case 10:
            slot = Slot(value: 10, image: UIImage(named: "Ten"), isRed: true)
        case 11:
            slot = Slot(value: 11, image: UIImage(named: "Jack"), isRed: false)
        case 12:
            slot = Slot(value: 12, image: UIImage(named: "Queen"), isRed: false)
        case 13:
            slot = Slot(value: 13, image: UIImage(named: "King"), isRed: true)
        default:
            slot = Slot(value: 0, image: UIImage(named: "Ace"), isRed: true)
        }
        return slot;
        
    }
}