//
//  Game.swift
//  PickUp Basketball
//
//  Created by Daniel Rica on 12/18/16.
//  Copyright © 2016 Viral Labs. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct Game {
    
    var title: String!
    var teamA: [String]!
    var teamB: [String]!
    var ref: FIRDatabaseReference?
    var key: String!
    
    init(title: String, teamA: [String], teamB: [String], key: String = "") {
        
        self.title = title
        self.teamA = teamA
        self.teamB = teamB
        self.key = key
        self.ref = FIRDatabase.database().reference()
        
    }
    
    init(snapshot: FIRDataSnapshot) {
        
        self.title = snapshot.value!["title"] as! String
        self.teamA = snapshot.value!["teamA"] as! [String]
        self.teamB = snapshot.value!["teamB"] as! [String]
        self.key = snapshot.key
        self.ref = snapshot.ref
    }
    
    func toAnyObject() -> [String: AnyObject] {
        
        return ["title": title, "teamA": teamA, "teamB": teamB]
    }
    
}