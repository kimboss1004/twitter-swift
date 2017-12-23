//
//  Helper.swift
//  Twitter
//
//  Created by admin on 12/22/17.
//  Copyright © 2017 kimboss. All rights reserved.
//

import Foundation
import UIKit

class Helper {
    static let shared = Helper()
    
    func switchStoryboard(storyBoard: String, identifier: String){
        let sBoard = UIStoryboard(name: storyBoard, bundle: nil)
        let vc = sBoard.instantiateViewController(withIdentifier: identifier)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = vc
    }
    
    func showOKAlert(title: String, message: String, viewController: UIViewController){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alert, animated: true)
        return
    }
}
