//
//  LoginViewController.swift
//  PickUp Basketball
//
//  Created by Daniel Rica on 12/18/16.
//  Copyright © 2016 Viral Labs. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    let networkingService = NetworkingService()
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToLogIn(storyboard: UIStoryboardSegue) {
        
        
        
    }
    
    @IBAction func logInAction(sender: AnyObject) {
        networkingService.signIn(emailTextField.text!, password: passwordTextField.text!)
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Home")
        presentViewController(vc, animated: true, completion: nil)
    }
    

}
