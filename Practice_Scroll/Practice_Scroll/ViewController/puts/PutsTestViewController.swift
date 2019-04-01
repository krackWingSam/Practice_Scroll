//
//  PutsTestViewController.swift
//  Practice_Scroll
//
//  Created by 강상우 on 01/04/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit


extension UIView {
    func getHeightConstraint(_ view : UIView) -> NSLayoutConstraint? {
        for constraint in  view.constraints {
            let first = constraint.firstAttribute
            
            if first == NSLayoutConstraint.Attribute.height {
                return constraint
            }
        }
        
        return nil
    }
}




let CELL_HEIGHT : CGFloat = 30.0
let TABLE_HEIGHT_DEFAULT : CGFloat = CELL_HEIGHT * 5.0

class PutsTestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, EXScrollPositionDelegate {
    
    @IBOutlet weak var view_SwitchRegion    : UIView!
    @IBOutlet weak var table_Rank           : UITableView!
    @IBOutlet weak var view_Content         : UIView!
    @IBOutlet weak var switch_Table         : UISwitch!
    
    var vc      : PutsTestInnerViewController!
    var startOffset : CGPoint    = CGPoint(x: 0, y: 0)
    var isTableShow : Bool       = true
    var isSwitchShow: Bool       = true

    override func viewDidLoad() {
        super.viewDidLoad()

        // load other vc
        let sb = UIStoryboard(name: "Main", bundle: nil)
        vc = (sb.instantiateViewController(withIdentifier: "menu_vc") as! PutsTestInnerViewController)
        vc.scrollDelegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        vc.view.frame = view_Content.frame
        vc.view.frame.origin.x = 0.0
        vc.view.frame.origin.y = 0.0
        view_Content.addSubview(vc.view)
    }
    
    
    //MARK: - Animations
    func showSwitchViewRegion() {
        let constraint = self.view.getHeightConstraint(view_SwitchRegion)
        constraint?.constant = 60.0
        
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
        }) { (Bool) in
            self.isSwitchShow = true
        }
    }
    
    func hideSwitchViewRegion() {
        let constraint = self.view.getHeightConstraint(view_SwitchRegion)
        constraint?.constant = 0
        
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
        }) { (Bool) in
            self.isSwitchShow = false
        }
    }
    
    
    //MARK: - EXScrollPositionDelegate
    func didScroll(_ scrollView: UIScrollView, isFirst: Bool) {
        let offset = scrollView.contentOffset
        
        if isFirst {
            startOffset = offset
            return
        }
        
        let originOffset = CGPoint(x: 0, y: startOffset.y - offset.y)
        
        if isTableShow {
            if originOffset.y < -100 {
                switch_Table.isOn = false
                startOffset = offset
            }
            action_Switch(switch_Table)
        }
        else if !isTableShow {
            if originOffset.y < -100 {
                hideSwitchViewRegion()
                startOffset = offset
            }
            else if originOffset.y > 50 {
                showSwitchViewRegion()
                startOffset = offset
            }
        }
        
        if !isTableShow && !isSwitchShow {
            if originOffset.y < -100 {
                vc.hideMenu()
                startOffset = offset
            }
            else if originOffset.y > 50 {
                vc.showMenu()
                startOffset = offset
            }
        }
    }
    
    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell!.textLabel?.text = String(format: "%d", indexPath.row)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CELL_HEIGHT
    }
    
    
    
    
    //MARK: - IBActions
    @IBAction func action_Switch(_ sender: UISwitch) {
        guard let constarint = self.view.getHeightConstraint(table_Rank) else { return }
        
        if sender.isOn {
            constarint.constant = TABLE_HEIGHT_DEFAULT
        }
        else {
            constarint.constant = 0.0
        }
        
        UIView.animate(withDuration: 0.25, animations: {
            self.view.layoutIfNeeded()
        }) { (Bool) in
            self.isTableShow = sender.isOn
        }
    }
    
    @IBAction func action_More(_ sender: UIButton) {
        let constraint_TableHeight = self.view.getHeightConstraint(table_Rank)
        let height_Table = constraint_TableHeight?.constant ?? 0.0
        let height_Content = view_Content.frame.size.height
        
        let newHeight = CGFloat(height_Table) + height_Content
        
        if newHeight == height_Table {
            constraint_TableHeight?.constant = 0.0
            switch_Table.isOn = false
        }
        else {
            constraint_TableHeight?.constant = newHeight
            switch_Table.isOn = true
        }
        
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }

}
