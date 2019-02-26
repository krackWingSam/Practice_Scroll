//
//  SHTestViewController.swift
//  Practice_Scroll
//
//  Created by 강상우 on 26/02/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

class SHTestViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var vc_1: UIViewController!
    var vc_2: UIViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let sb = self.storyboard
        vc_1 = sb?.instantiateViewController(withIdentifier: "ContentViewController")
        vc_2 = sb?.instantiateViewController(withIdentifier: "SecondContentViewController")
        
        vc_1.view.frame.origin = CGPoint(x: 0, y: 0)
        vc_1.view.frame.size = self.view.frame.size
        vc_2.view.frame.origin = CGPoint(x: self.view.frame.size.width, y: 0)
        vc_2.view.frame.size = self.view.frame.size
        
        scrollView.addSubview(vc_1.view)
        scrollView.addSubview(vc_2.view)
        scrollView.contentSize.width = self.view.frame.size.width * 2
        scrollView.contentSize.height = self.view.frame.size.height * 2
    }
    

    

}
