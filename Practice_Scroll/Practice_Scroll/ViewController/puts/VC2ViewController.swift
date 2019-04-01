//
//  VC2ViewController.swift
//  Practice_Scroll
//
//  Created by 강상우 on 01/04/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

class VC2ViewController: UIViewController, UIScrollViewDelegate {
    
    public var scrollViewDelegate: EXScrollPositionDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    //MARK: - UIScrollViewDelegate
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        guard scrollViewDelegate != nil else { return }
        
        scrollViewDelegate?.didScroll(scrollView, isFirst: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollViewDelegate != nil else { return }
        
        scrollViewDelegate?.didScroll(scrollView, isFirst: false)
    }
}
