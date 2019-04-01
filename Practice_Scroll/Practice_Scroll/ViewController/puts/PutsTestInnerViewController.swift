//
//  PutsTestInnerViewController.swift
//  Practice_Scroll
//
//  Created by 강상우 on 01/04/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

let DEFAULT_MENU_HEIGHT: CGFloat = 60

class PutsTestInnerViewController: UIViewController, EXScrollPositionDelegate {
    
    @IBOutlet weak var view_Menu        : UIView!
    @IBOutlet weak var scroll_Content   : UIScrollView!
    
    var vc1                             : VC1ViewController!
    var vc2                             : VC2ViewController!
    
    var isShowMenu                      : Bool = true

    public var scrollDelegate           : EXScrollPositionDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // load vc
        let sb = UIStoryboard(name: "Main", bundle: nil)
        vc1 = (sb.instantiateViewController(withIdentifier: "vc1") as! VC1ViewController)
        vc2 = (sb.instantiateViewController(withIdentifier: "vc2") as! VC2ViewController)
        
        vc1.scrollViewDelegate = self
        vc2.scrollViewDelegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // landing vc
        vc1.view.frame.origin.x = 0
        vc1.view.frame.origin.y = 0
        vc1.view.frame.size.width = scroll_Content.frame.size.width
        vc1.view.frame.size.height = scroll_Content.frame.size.height
        scroll_Content.addSubview(vc1.view)
        
        vc2.view.frame.origin.x = scroll_Content.frame.size.width
        vc2.view.frame.origin.y = 0
        vc2.view.frame.size.width = scroll_Content.frame.size.width
        vc2.view.frame.size.height = scroll_Content.frame.size.height
        scroll_Content.addSubview(vc2.view)
        
        scroll_Content.contentSize.width = scroll_Content.bounds.size.width * 2.0
        scroll_Content.contentSize.height = scroll_Content.bounds.size.height
    }
    
    
    
    //MARK: - Animation
    func showMenu() {
        let constraint = self.view.getHeightConstraint(view_Menu)
        constraint?.constant = DEFAULT_MENU_HEIGHT
        
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
        }) { (Bool) in
            self.isShowMenu = true
        }
    }
    
    func hideMenu() {
        let constraint = self.view.getHeightConstraint(view_Menu)
        constraint?.constant = 0
        
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
        }) { (Bool) in
            self.isShowMenu = false
        }
    }
    
    
    
    //MARK: - EXScrollPositionDelegate
    func didScroll(_ scrollView: UIScrollView, isFirst: Bool) {
        guard scrollDelegate != nil else { return }
        scrollDelegate!.didScroll(scrollView, isFirst: isFirst)
    }
    
    
    //MARK: - IBAction
    @IBAction func action_LeftButton(_ sender: UIButton) {
        scroll_Content.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    @IBAction func action_RightButton(_ sender: UIButton) {
        scroll_Content.setContentOffset(CGPoint(x: scroll_Content.frame.size.width, y: 0), animated: true)
    }
}
