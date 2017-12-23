//
//  ViewController.swift
//  Twitter
//
//  Created by admin on 12/19/17.
//  Copyright © 2017 kimboss. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let query = PFQuery(className: "People")
        query.whereKey("age", equalTo: 19)
        let query2 = PFQuery(className: "People")
        query2.whereKey("firstname", equalTo: "Nick")
        let findQuery = PFQuery.orQuery(withSubqueries: [query, query2])
        findQuery.findObjectsInBackground { (objects, error) in
            if(error == nil){
                for object in objects!{
                    print("\(object["firstname"]!) : \(object["lastname"]!) -- \(object["age"]!)")
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logout(_ sender: Any) {
        let alert = UIAlertController(title: "Do you want to logout?", message: "Click cancel to remain in the app", preferredStyle: .alert)
        let logoutAction = UIAlertAction(title: "Logout", style: .default) { (action) in
            PFUser.logOut()
            Helper.shared.switchStoryboard(storyBoard: "Login", identifier: "login")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(logoutAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    


}

