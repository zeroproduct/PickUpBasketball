//
//  GameCell.swift
//  PickUp Basketball
//
//  Created by Daniel Rica on 12/18/16.
//  Copyright © 2016 Viral Labs. All rights reserved.
//

import UIKit

class GameCell: UITableViewCell {
    
    var gameState = State.EMPTY
    var timeStart = ""
    var capacity = 5
    var teamA = [String]()
    var teamB = [String]()
        
    enum State: Int {
        case EMPTY = 0
        case BOOKED = 1
    }
    
    func setEmpty() {
        gameState = State.EMPTY
    }
    
    func setBooked() {
        gameState = State.BOOKED
    }
    
    func getState() -> Int {
        return gameState.rawValue
    }
    
    
    func setStart(start:String) {
        timeStart = start
    }
    
    func playerBooked() {
        capacity -= 1
    }

    

}
