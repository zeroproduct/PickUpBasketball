//
//  MyProfileViewController.swift
//  PickUp Basketball
//
//  Created by Daniel Rica on 12/18/16.
//  Copyright © 2016 Viral Labs. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class MyProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var studentID: UILabel!
    @IBOutlet weak var email: UILabel!
    
    var dbRef: FIRDatabaseReference! {
        return FIRDatabase.database().reference()
    }
    
    var storageRef: FIRStorage! {
        return FIRStorage.storage()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if FIRAuth.auth()?.currentUser == nil {
            
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login")
            presentViewController(vc, animated: true, completion: nil)
        } else {
        
        dbRef.child("Users/\(FIRAuth.auth()!.currentUser!.uid)").observeEventType(.Value, withBlock: { (snapshot) in
            
            dispatch_async(dispatch_get_main_queue(), {
                
                let user = User(snapshot: snapshot)
                self.username.text = user.username
                self.studentID.text = user.studentID
                self.email.text = user.email
                
                let imageURL = String(user.photoURL)
                
                self.storageRef.referenceForURL(imageURL).dataWithMaxSize(1 * 1024 * 1024, completion: { (data, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        if let data = data {
                            self.profileImage.image = UIImage(data: data)
                        }
                    }
                })
                
            })
            
        }) { (error) in
            print(error.localizedDescription)
        }
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func logOut(sender: AnyObject) {
        if FIRAuth.auth()?.currentUser != nil {
        
            do {
                try   FIRAuth.auth()?.signOut()
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login")
                presentViewController(vc, animated: true, completion: nil)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }
    }
}
