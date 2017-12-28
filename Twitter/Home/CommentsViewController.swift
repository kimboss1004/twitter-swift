//
//  CommentsViewController.swift
//  Twitter
//
//  Created by admin on 12/27/17.
//  Copyright © 2017 kimboss. All rights reserved.
//

import UIKit
import Parse

class CommentsViewController: UIViewController {

    @IBOutlet weak var commentTf: UITextField!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var selectedObject: PFObject?
    var commentsArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentsArray = selectedObject!["comments"] as? [String] ?? [String]()
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func comment(_ sender: Any) {
        if commentTf.text?.count == 0 {
            Helper.shared.showOKAlert(title: "Error", message: "No characters inputted", viewController: self)
            return
        }
        selectedObject?.add(commentTf.text!, forKey: "comments")
        selectedObject?.saveInBackground(block: { (success, error) in
            if success{
                self.commentsArray.append(self.commentTf.text!)
                self.tableView.reloadData()
                self.commentTf.text = ""
            }
            else{
                Helper.shared.showOKAlert(title: "Error", message: (error?.localizedDescription)!, viewController: self)
            }
        })
    }
    
    @IBAction func flag(_ sender: Any) {
        if let selectedObj = selectedObject {
            selectedObj.incrementKey("flagged")
            selectedObj.saveInBackground()
        }
    }
    
}

extension CommentsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath)
        let eachComment = commentsArray[indexPath.row]
        print(eachComment)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = eachComment
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsArray.count
    }
}
