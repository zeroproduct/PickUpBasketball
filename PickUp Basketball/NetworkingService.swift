//
//  NetworkingService.swift
//  PickUp Basketball
//
//  Created by Daniel Rica on 12/18/16.
//  Copyright © 2016 Viral Labs. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

struct NetworkingService {
    
    var dbRef: FIRDatabaseReference! {
        return FIRDatabase.database().reference()
    }
    
    var storageRef: FIRStorageReference! {
        return FIRStorage.storage().reference()
    }
    
    private func saveInfo(user: FIRUser!, username: String, password: String, studentID: String) {
        
        let userInfo = ["email": user.email!, "username": username, "studentID": studentID, "uid": user.uid, "photoURL": String(user.photoURL!)]
        
        let userRef = dbRef.child("Users").child(user.uid)
        
        userRef.setValue(userInfo)
        
        
        signIn(user.email!, password: password)
        
    }
    
    func signIn(email: String, password: String) {
        
        FIRAuth.auth()?.signInWithEmail(email, password: password, completion: { (user, error) in
            if error == nil {
                
                if let user = user {
                    print("\(user.displayName!) has signed in!")
                }
                
            } else {
                
                print(error!.localizedDescription)
            
            }
        })
    }
    
    private func setUserInfo(user: FIRUser!, username: String, password: String, studentID: String, data: NSData!) {
        
        let imagePath = "profileImage\(user.uid)/userPic.jpg"
        
        let imageRef = storageRef.child(imagePath)
        
        //Create Metadata for the image
        let metaData = FIRStorageMetadata()
        metaData.contentType = "image/jpeg"
        
        //Save the user image in the Firebase Storage File
        imageRef.putData(data, metadata: metaData) { (metaData, error) in
            if error == nil {
                
                let changeRequest = user.profileChangeRequest()
                changeRequest.displayName = username
                changeRequest.photoURL = metaData!.downloadURL()
                changeRequest.commitChangesWithCompletion({ (error) in
                    if error == nil {
                        self.saveInfo(user, username: username, password: password, studentID: studentID)
                        
                    } else {
                        print(error!.localizedDescription)

                    }
                })
                
            } else {
                print(error!.localizedDescription)

            }
        }
        
    }
    
    
    func signUp(email: String, username: String, password: String, studentID: String, data: NSData!) {
        
        FIRAuth.auth()?.createUserWithEmail(email, password: password, completion: { (user, error) in
            if error == nil {
                self.setUserInfo(user, username: username, password: password, studentID: studentID, data: data)
                
            } else {
                print(error!.localizedDescription)

            }
        })
        
    }

    
}

















