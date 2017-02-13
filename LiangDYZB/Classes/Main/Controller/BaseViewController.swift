//
//  BaseViewController.swift
//  LiangDYZB
//
//  Created by qu on 2017/1/24.
//  Copyright © 2017年 qu. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

//    var contentView : UIView?

    /*
     Apple 给我们的建议是如果能够确定在访问时不会已被释放的话，
     尽量使用 unowned,如果存在被释放的可能，那就选择用 weak。
     */
    fileprivate lazy var animImageView:UIImageView = {
        let imageView = UIImageView(image: UIImage(named:  "img_loading_1"))
        imageView.animationImages = [UIImage(named : "img_loading_1")!, UIImage(named : "img_loading_2")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()

    }


  
}
extension BaseViewController {
    func setupUI() {
        // 1.隐藏内容的View
//        contentView?.isHidden = true
        
        // 2.添加执行动画的UIImageView
        view.addSubview(animImageView)
        animImageView.center = view.center
        // 3.给animImageView执行动画
        animImageView.startAnimating()
        
        // 4.设置view的背景颜色
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }
    
    func loadDataFinished() {
        // 1.停止动画
        animImageView.stopAnimating()
        
        // 2.隐藏animImageView
        animImageView.isHidden = true
        
        // 3.显示内容的View
//        contentView?.isHidden = false
    }
}
