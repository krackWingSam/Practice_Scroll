//
//  ScrollInScrollViewController.swift
//  Practice_Scroll
//
//  Created by 강상우 on 12/03/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

class ScrollInScrollViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var popupView: UIView!
    @IBOutlet var popupScrollView: UIScrollView!
    
    
    var scrollViews: [UIScrollView] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let viewFrame = self.view.frame
        popupView.frame = CGRect(x: 40, y: 80, width: viewFrame.size.width-80, height: viewFrame.size.height - 160)
    }
    
    func initScrollView() {
        if scrollViews.count != 0 {
            return
        }
        
        popupScrollView.isPagingEnabled = true
        
        let imageNames = ["1", "2", "3", "4"]
        var images: [UIImage] = []
        for name in imageNames {
            let path = Bundle.main.path(forResource: name, ofType: "png")
            let image = UIImage(contentsOfFile: path!)
            images.append(image!)
        }
        
        for i in 0..<images.count {
            let imageView = UIImageView(image: images[i])
            let width = popupScrollView.frame.size.width
            let height = popupScrollView.frame.size.height
            imageView.frame = CGRect(x: 0, y: 0, width: width, height: height)
            imageView.contentMode = .scaleAspectFit
            
            let scrollView = UIScrollView(frame: CGRect(x: CGFloat(i)*width, y: 0, width: width, height: height))
            scrollView.addSubview(imageView)
            scrollView.minimumZoomScale = 1.0
            scrollView.maximumZoomScale = 3.0
            scrollView.delegate = self
            scrollViews.append(scrollView)
            
            popupScrollView.addSubview(scrollView)
        }
        
        popupScrollView.contentSize = CGSize(width: popupScrollView.frame.size.width * CGFloat(scrollViews.count), height: popupScrollView.frame.size.height)
    }
    
    //MARK: - Animation
    func showPopupView() {
        
        if popupView.superview != nil {
            return
        }
        
        popupView.alpha = 0.0
        self.view.addSubview(popupView)
        
        UIView.animate(withDuration: 0.2, animations: {
            self.popupView.alpha = 1.0
        }) { (Bool) in
            self.initScrollView()
        }
    }
    
    func hidePopupView() {
        UIView.animate(withDuration: 0.2, animations: {
            self.popupView.alpha = 0.0
        }) { (Bool) in
            self.popupView.removeFromSuperview()
        }
    }
    
    
    //MARK: - IBAction
    @IBAction func action_ShowSomthin(_ sender: UIButton) {
        showPopupView()
    }
    
    @IBAction func action_hideThat(_ sender: UIButton) {
        hidePopupView()
    }

    
    //MARK: - UIScrollViewDelegate
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return scrollView.subviews[0]
    }
}
