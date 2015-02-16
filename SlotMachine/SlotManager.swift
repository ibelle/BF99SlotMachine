//
//  SlotManager.swift
//  SlotMachine
//
//  Created by HUGE | Isaiah Belle on 2/15/15.
//  Copyright (c) 2015 IsaiahBelleDigital. All rights reserved.
//

import Foundation

class SlotManager{
    
    class func unpackSlotsToRows(slots: [[Slot]]) -> [[Slot]]
    {

        
        var slotsInRows:[[Slot]] = slots //Ensure Capacity
        
        //Small but very clear optimization from Notes
        for i in 0...2 {
            for j in 0...2 {
                slotsInRows[i][j] = slots[j][i]
            }
        }
        return slotsInRows
    }
    
    class func computeWinnings(slots: [[Slot]]) -> Int {
        var slotsInRows = unpackSlotsToRows(slots)
        var winnings = 0
        
        var flusWinCount:Int = 0
        var threeOfAkindWinCount:Int = 0
        var straightWinCount:Int = 0
        
        for slotRow in slotsInRows {
            if checkForFlush(slotRow) {
                println("FLUSH!")
                winnings += 1
                flusWinCount += 1
            }
            
            if checkThreeInARow(slotRow) {
                println("THREE IN A ROW!")
                winnings += 1
                straightWinCount += 1
            }
            
            if checkThreeOfAKind(slotRow) {
                println("THREE OR A KIND!")
                winnings += 3
                threeOfAkindWinCount += 1
            }
            
            
        }
        
        if straightWinCount == 3 {
            println("EPIC STRAIGHT")
            winnings += 1000
        }

        
        if flusWinCount == 3 {
            println("ROYAL FLUSH!")
            winnings += 15
        }
        
        
        if threeOfAkindWinCount == 3 {
            println("EPIC 3 OF A KIND")
            winnings += 500
        }
        
        if winnings == 0 {
            println("NO WINNER!")
        }
        return winnings
    }
    
    class func checkForFlush(slotRow:[Slot]) -> Bool{
        var isAllRed:Bool = true
        var isAllBlack:Bool = true
        
        for slot in slotRow {
            isAllBlack = isAllBlack && !slot.isRed
            isAllRed = isAllRed && slot.isRed
        }
        
        
        return isAllBlack || isAllRed
    }
    class func checkThreeInARow(slotRow: [Slot]) -> Bool {
        
        //Great Use of MAP, SORT & ENUMERATE from  comments
        var values = slotRow.map({$0.value})
        
        values.sort({$0 < $1})
        
        for (i, value) in enumerate(values) {
            if i > 0 && value != values[i - 1] + 1 {
                
                return false
            }
        }
        return true
    }
    
    class func checkThreeOfAKind(slotRow:[Slot]) -> Bool {
        var values = slotRow.map({$0.value})
        
        for (i, value) in enumerate(values) {
            if i > 0 && value != values[i - 1] {
                return false
            }
        }
        
        return true
    }
}