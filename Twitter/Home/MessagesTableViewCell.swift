//
//  MessagesTableViewCell.swift
//  Twitter
//
//  Created by admin on 12/23/17.
//  Copyright © 2017 kimboss. All rights reserved.
//

import UIKit
import Parse

class MessagesTableViewCell: UITableViewCell {


    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var likesButton: UIButton!
    
    @IBOutlet weak var commentsButton: UIButton!
    
    func setMessageCell(message: PFObject) {
        usernameLabel.text = message["sender"] as? String ?? ""
        messageLabel.text = message["message"] as? String ?? ""
        likesButton.setTitle("\((message["likes"] as? [String] ?? [String]()).count) Likes", for: .normal)
        commentsButton.setTitle("\((message["comments"] as? [String] ?? [String]()).count) Comments", for: .normal)
    }
}
