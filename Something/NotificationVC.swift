//
//  NotificationVC.swift
//  Something
//
//  Created by Capgemini-DA067 on 9/26/22.
//

import UIKit

import MyCartNotification

import UserNotifications


class NotificationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    

    @IBAction func notificationButtonClicked(_ sender: Any) {
        
        // calling the notification function from notification framework
        let obj = OrderNotification()
        obj.myLocalNotification()
        
    }
   
}
