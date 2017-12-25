//
//  PostViewController.swift
//  Twitter
//
//  Created by admin on 12/22/17.
//  Copyright © 2017 kimboss. All rights reserved.
//

import UIKit
import Parse
class PostViewController: UIViewController {

    
    @IBOutlet weak var messageTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTextView.becomeFirstResponder()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func post(_ sender: Any) {
        if messageTextView.text.count == 0 {
            Helper.shared.showOKAlert(title: "Required", message: "Please type some message", viewController: self)
            return
        }
        let messageObj = PFObject(className: "Messages")
        messageObj["sender"] = (PFUser.current()?.username)!
        messageObj["message"] = messageTextView.text
        messageObj["likes"] = [String]()
        messageObj["comments"] = [String]()
        messageObj["flagged"] = 0
        
        messageObj.saveInBackground { (success, error) in
            self.messageTextView.text = ""
            Helper.shared.showOKAlert(title: "Shared!", message: "You're message was posted succesfully", viewController: self)
        }
    }
    
}
