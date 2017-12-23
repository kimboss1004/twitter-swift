//
//  LoginViewController.swift
//  Twitter
//
//  Created by admin on 12/20/17.
//  Copyright © 2017 kimboss. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(_ sender: Any) {
        guard let username = usernameTf.text?.lowercased(), let password = passwordTf.text else { return }
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if(error == nil){
                Helper.shared.switchStoryboard(storyBoard: "Main", identifier: "home")
            }else{
                Helper.shared.showOKAlert(title: "Error", message: (error?.localizedDescription)!, viewController: self)
            }
        }
    }
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
