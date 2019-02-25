//
//  CustomPageScrollViewController.swift
//  Practice_Scroll
//
//  Created by 강상우 on 25/02/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

class CustomPageScrollViewController: UIViewController {
    
    @IBOutlet weak var view_Content   : UIView!
    @IBOutlet weak var contentWidth   : NSLayoutConstraint!
    @IBOutlet weak var view_Properties: UIView!
    @IBOutlet weak var textField_Count: UITextField!
    
    var array_View: [UIView] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func resetUI() {
        let countOfPage:Int = Int(textField_Count.text!)!
        
        let width:CGFloat = self.view.frame.size.width
        let height:CGFloat = self.view.frame.size.height
        
        // remove all subviews
        for view in view_Content.subviews {
            view.removeFromSuperview()
        }
        
        // make views
        for i in 0..<countOfPage {
            if i < array_View.count {
                continue
            }
            
            let view: UIView = UIView()
            view.frame = CGRect(x: CGFloat(i) * width, y: 0, width: width, height: height)
            array_View.append(view)
        }
        
        // recolor
        for i in 0..<countOfPage {
            let view: UIView = array_View[i]
            let colorGrading:CGFloat = 1 / CGFloat(array_View.count) * CGFloat(i)
            let color = UIColor(hue: colorGrading, saturation: 1, brightness: 1, alpha: 1)
            view.backgroundColor = color
        }
        
        // add
        for view in array_View {
            view_Content.addSubview(view)
        }
        
        contentWidth.constant = self.view.frame.size.width * CGFloat(array_View.count)
    }
    
    
    // MARK: -
    // MARK: IBActions
    @IBAction func action_BackgroundTouch(_ sender: Any) {
        textField_Count.resignFirstResponder()
    }
    
    @IBAction func action_Properties(sender: UIBarButtonItem) {
        if view_Properties.superview != nil {
            return
        }
        
        view_Properties.frame.size = self.view.frame.size
        view_Properties.frame.origin.y = self.view.frame.size.height
        
        self.view.addSubview(view_Properties)
        
        UIView.animate(withDuration: 0.2) {
            self.view_Properties.frame.origin.y = 0
        }
    }
    
    @IBAction func action_Close(sender: UIButton) {
        self.resetUI()
        
        UIView.animate(withDuration: 0.2, animations: {
            self.view_Properties.frame.origin.y = self.view.frame.size.height
        }) { (Bool) in
            self.view_Properties.removeFromSuperview()
        }
    }
}
