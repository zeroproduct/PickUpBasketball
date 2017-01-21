//
//  User.swift
//  PickUp Basketball
//
//  Created by Daniel Rica on 12/18/16.
//  Copyright © 2016 Viral Labs. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct User {
    
    var username: String!
    var email: String!
    var photoURL: String!
    var studentID: String!
    var ref: FIRDatabaseReference!
    var key: String!
    
    init(snapshot: FIRDataSnapshot) {
        
        key = snapshot.key
        username = snapshot.value!["username"] as! String
        email = snapshot.value!["email"] as! String
        photoURL = snapshot.value!["photoURL"] as! String
        studentID = snapshot.value!["studentID"] as! String
        ref = snapshot.ref
        
    }
}