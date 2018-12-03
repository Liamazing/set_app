//
//  ViewController.swift
//  set_app
//
//  Created by Mia Bendy on 12/2/18.
//  Copyright © 2018 Mia Bendy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

//view controller for home screen
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        FirebaseApp.configure() //configure the database
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
