//
//  ViewController.swift
//  XKCDToday
//
//  Created by Mikolaj Piechocki on 01/10/2018.
//  Copyright © 2018 Mikolaj Piechocki. All rights reserved.
//

import UIKit
import Networking

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let a = XKCDApiClient()
        a.getCurrent()
    }


}

