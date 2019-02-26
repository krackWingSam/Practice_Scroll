//
//  SecondContentViewController.swift
//  Practice_Scroll
//
//  Created by 강상우 on 26/02/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

class SecondContentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // MARK -
    // MARK IBActions
    @IBAction func action_Switch(sender: UISwitch) {
        print("Switch status is " + String(sender.isOn))
    }
}
