//
//  SmallScrollTestViewController.swift
//  Practice_Scroll
//
//  Created by 강상우 on 25/02/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

class SmallScrollTestViewController: UIViewController {
    
    @IBOutlet weak var scrollView       : UIScrollView!
    @IBOutlet weak var contentView      : UIView!
    @IBOutlet weak var textField_Width  : UITextField!
    @IBOutlet weak var textField_Height : UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self .resetUI()
    }
    
    func getConstraints() {
        let array_Constraints = contentView.constraints
        
        for constraint: NSLayoutConstraint in array_Constraints {
            switch (constraint.firstAttribute) {
                case NSLayoutConstraint.Attribute.width:
                    constraint.constant = CGFloat(truncating: NumberFormatter().number(from: textField_Width.text!)!)
                    break;
                
                case NSLayoutConstraint.Attribute.height:
                    constraint.constant = CGFloat(truncating: NumberFormatter().number(from: textField_Height.text!)!)
                    break;
                
                default:
                    break;
            }
        }
    }
    
    func resetUI() {
        print("")
    }
    

    // MARK : -
    // MARK : IBActions
    @IBAction func action_ResetScrollView(sender: UIButton!) {
        self.getConstraints()
        self .resetUI()
    }
    
    @IBAction func action_BackgroundTouch(_ sender: Any) {
        textField_Width.resignFirstResponder()
        textField_Height.resignFirstResponder()
    }

}
