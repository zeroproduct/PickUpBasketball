//
//  GameDetailViewController.swift
//  PickUp Basketball
//
//  Created by Daniel Rica on 12/18/16.
//  Copyright © 2016 Viral Labs. All rights reserved.
//

import UIKit
import Firebase

class GameDetailViewController: UIViewController {
    
    @IBOutlet weak var teamBView: UITextView!
    @IBOutlet weak var teamAView: UITextView!
    var time:String!
    @IBOutlet weak var selectedTime: UILabel!
    
    var teamA = [String]()
    var teamB = [String]()
    
    var teamACounter = 5
    var teamBCounter = 5
    
    var dbRef: FIRDatabaseReference! {
        return FIRDatabase.database().reference()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedTime.text = time

        // Do any additional setup after loading the view.
        
//        dbRef.child("GameTime/teamA)").observeEventType(.Value, withBlock: { (snapshot) in
//            
//            dispatch_async(dispatch_get_main_queue(), {
//                
//                var game = Game(snapshot: snapshot)
//                
//                if(game.teamA == nil) {
//                    game.teamB.append("A")
//                } else {
//                    self.teamAView.text = "\(game.teamA.joinWithSeparator("\n"))"
//                }
//                
//            })
//            
//        }) { (error) in
//            print(error.localizedDescription)
//        }
//        
//        dbRef.child("GameTime/teamB)").observeEventType(.Value, withBlock: { (snapshot) in
//            
//            dispatch_async(dispatch_get_main_queue(), {
//                
//                var game = Game(snapshot: snapshot)
//                
//                if(game.teamB == nil) {
//                    game.teamB.append("B")
//                } else {
//                    self.teamBView.text = "\(game.teamB.joinWithSeparator("\n"))"
//                }
//                
//            })
//            
//        }) { (error) in
//            print(error.localizedDescription)
//        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func joinTeamA(sender: AnyObject) {
        
        if(teamACounter > 0) {
            teamA.append((FIRAuth.auth()?.currentUser?.displayName)!)
            teamACounter -= 1
        } else if (teamACounter == 0) {
            print("Too many players")
        }
        
        teamAView.text = "\(teamA.joinWithSeparator("\n"))"
        
        let gameRef = dbRef.child("GameTime")
        let game = Game(title: time, teamA: teamA, teamB: teamB)
        
        gameRef.setValue(game.toAnyObject())
        
    }


    @IBAction func joinTeamB(sender: AnyObject) {
        if(teamBCounter > 0) {
            teamB.append((FIRAuth.auth()?.currentUser?.displayName)!)
            teamBCounter -= 1
        } else if (teamBCounter == 0) {
            print("Too many players")
        }
        
        teamBView.text = "\(teamB.joinWithSeparator("\n"))"
        
        let gameRef = dbRef.child("GameTime")
        let game = Game(title: time, teamA: teamA, teamB: teamB)
        
        gameRef.setValue(game.toAnyObject())

    }

}
