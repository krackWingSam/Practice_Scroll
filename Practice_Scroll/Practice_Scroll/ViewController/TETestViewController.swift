//
//  TETestViewController.swift
//  Practice_Scroll
//
//  Created by 강상우 on 11/03/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

class TETestViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var scrollViewForPicture: UIScrollView!
    @IBOutlet var popupView: UIView!
    var contentView: UIView!
    var imageViews: [UIImageView] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initScrollView()
    }
    
    func initScrollView() {
        if imageViews.count != 0 {
            return
        }
        
        let imageNames = ["1", "2", "3", "4"]
        var images: [UIImage] = []
        for name in imageNames {
            let path = Bundle.main.path(forResource: name, ofType: "png")
            let image = UIImage(contentsOfFile: path!)
            images.append(image!)
        }
        
        contentView = UIView()
        
        for i in 0..<images.count {
            let imageView = UIImageView(image: images[i])
            let width = self.view.frame.size.width-40
            let height = self.view.frame.size.height-240
            imageView.frame = CGRect(x: CGFloat(i)*width, y: 0, width: width, height: height)
            imageView.contentMode = .scaleAspectFit
            imageViews.append(imageView)
            contentView.addSubview(imageView)
            contentView.frame = CGRect(x: 0, y:0, width: CGFloat(i+1)*width, height: height)
        }
        scrollViewForPicture.addSubview(contentView)
        scrollViewForPicture.contentSize = contentView.frame.size
        
        scrollViewForPicture.isPagingEnabled = true
    }
    
    //MARK: - IBActions
    @IBAction func action_ShowScroll(_ sender: UIButton) {
        popupView.alpha = 0.0
        popupView.frame = CGRect(x: 20, y: 80, width: self.view.frame.size.width-40, height: self.view.frame.size.height-160)
        
        
        self.view .addSubview(popupView)
        
        UIView.animate(withDuration: 0.2, animations: {
            self.popupView.alpha = 1.0
        }) { (Bool) in
            self.initScrollView()
        }
    }
    
    @IBAction func action_HideScroll(_ sender: Any) {
        UIView.animate(withDuration: 0.2, animations: {
            self.popupView.alpha = 0.0
        }) { (Bool) in
            self.popupView.removeFromSuperview()
        }
    }
    
    
    //MARK: - UIScrollViewDelegate
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        if scrollView.zoomScale <= 1.0 {
            scrollView.isPagingEnabled = true
        }
        else {
            scrollView.isPagingEnabled = false
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return contentView
    }
    
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        if !scrollView.isPagingEnabled {
//            let contentSize = scrollView.contentSize
//            let contentOffset = scrollView.contentOffset
//            let count = imageViews.count
//
//            //calc page
//            let page = getPage(contentOffset, size: contentSize, count: count)
//
//            let minScrollX = (contentSize.width / CGFloat(count)) * CGFloat(page)
//            let maxScrollX = (contentSize.width / CGFloat(count)) * CGFloat(page + 1)
//
//            print(minScrollX)
//            print(maxScrollX)
//            print(contentOffset)
//            print("=============")
//            if contentOffset.x < minScrollX {
//                scrollView.setContentOffset(CGPoint(x: minScrollX, y: contentOffset.y), animated: true)
//            }
//            if contentOffset.x > maxScrollX {
//                scrollView.setContentOffset(CGPoint(x: maxScrollX, y: contentOffset.y), animated: true)
//            }
//        }
//    }
    
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        if !scrollView.isPagingEnabled {
//            print("view did end dragging")
//            
//            let contentSize = scrollView.contentSize
//            let contentOffset = scrollView.contentOffset
//            let count = imageViews.count
//            
//            let page = getPage(contentOffset, size: contentSize, count: count)
//            
//            let width = (contentSize.width / CGFloat(count))
//            let minScrollX = width * CGFloat(page)
//            let maxScrollX = (contentSize.width / CGFloat(count)) * CGFloat(page + 1)
//            
//            scrollView.decelerationRate = .fast
//            if contentOffset.x < minScrollX && targetPoint.x > minScrollX - (width/2) {
//                print("current page")
//                scrollView.setContentOffset(CGPoint(x: minScrollX, y: targetPoint.y), animated: true)
//            }
//            else if targetPoint.x < minScrollX - (width/2) {
//                print("before page")
//                var targetX = minScrollX - scrollView.frame.size.width
//                if targetX < 0 {
//                    targetX = 0
//                }
//                scrollView.setContentOffset(CGPoint(x: targetX, y: targetPoint.y), animated: true)
//            }
//        }
//    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if !scrollView.isPagingEnabled {
            print("view will end dragging")
            
            let targetPoint:CGPoint = targetContentOffset.withMemoryRebound(to: CGPoint.self, capacity: 8) { ptr in
                return ptr.pointee
            }
            
            let contentSize = scrollView.contentSize
            let contentOffset = scrollView.contentOffset
            let count = imageViews.count
            
            //calc page
            let page = getPage(contentOffset, size: contentSize, count: count)
            print(page)
            
            let width = (contentSize.width / CGFloat(count))
            let minScrollX = width * CGFloat(page)
            let maxScrollX = (contentSize.width / CGFloat(count)) * CGFloat(page + 1)
            
            scrollView.decelerationRate = .fast
            if targetPoint.x < minScrollX && targetPoint.x > minScrollX - (width/2) {
                print("current page")
                scrollView.setContentOffset(CGPoint(x: minScrollX, y: targetPoint.y), animated: true)
            }
            else if targetPoint.x < minScrollX - (width/2) {
                print("before page")
                var targetX = minScrollX - scrollView.frame.size.width
                if targetX < 0 {
                    targetX = 0
                }
                scrollView.setContentOffset(CGPoint(x: targetX, y: targetPoint.y), animated: true)
            }
            
            
            print("======:")
            print(targetPoint)
            print(minScrollX)
            print(maxScrollX)
            print(contentOffset)
            print("======:")
        }
    }
    
    func getPage(_ offset: CGPoint, size: CGSize, count: Int) -> Int {
        let width = size.width / CGFloat(count)
        let margin = width / 2
        var page = 0
        
        for i in 0..<count {
            if offset.x < CGFloat(i)*width + margin {
                page = i
                break
            }
        }
        
        return page
    }
}
