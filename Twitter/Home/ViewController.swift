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
    
    var messages = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        title = PFUser.current()?.username
        getMessages()
    }

    func getMessages(){
        let query = PFQuery(className: "Messages")
        query.findObjectsInBackground { (objects, error) in
            if let objects = objects {
                self.messages = objects
                self.tableView.reloadData()
            }
        }
        
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

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessagesTableViewCell
        let messageObj = messages[indexPath.row]
        cell.setMessageCell(message: messageObj)
        
        // like button
        cell.likesButton.tag = indexPath.row
        cell.likesButton.addTarget(self, action: #selector(likeClicked(sender: )), for: .touchUpInside)

//        cell.commentsButton.tag = indexPath.row
//        cell.commentsButton.addTarget(self, action: #selector(commentClicked(sender:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
   @objc func likeClicked(sender: UIButton){
        let message = messages[sender.tag]
        let currentUsername = PFUser.current()?.username!
        let sender = message["sender"] as? String ?? ""
        var likesArray = message["likes"] as? [String] ?? [String]()
    
        if(currentUsername == sender){
            Helper.shared.showOKAlert(title: "Not Allowed", message: "You are not allowed to like your own message", viewController: self)
            return
        }
        if likesArray.contains(currentUsername!){
            Helper.shared.showOKAlert(title: "Not Allowed", message: "You have already liked this post", viewController: self)
            return
        }
    
        likesArray.append(currentUsername!)
        message["likes"] = likesArray
        message.saveInBackground { (success, error) in
            self.tableView.reloadData()
        }
    }
    
    @objc func commentClicked(sender: UIButton){
        print(sender.tag)
    }
}





