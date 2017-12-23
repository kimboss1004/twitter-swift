//
//  RegisterViewController.swift
//  Twitter
//
//  Created by admin on 12/20/17.
//  Copyright © 2017 kimboss. All rights reserved.
//

import UIKit
import Parse

class RegisterViewController: UIViewController {

    
    @IBOutlet weak var usernameTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func register(_ sender: Any) {
        guard let username = usernameTf.text, let password = passwordTf.text else { return }
        
        let user = PFUser()
        user.username = username.lowercased()
        user.password = password
        user.signUpInBackground { (succeed, error) in
            if(succeed){
                Helper.shared.switchStoryboard(storyBoard: "Main", identifier: "home")
            }
            else{
                let localized = error?.localizedDescription
                Helper.shared.showOKAlert(title: "Error", message: localized!, viewController: self)
            }
            
        }
        
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
