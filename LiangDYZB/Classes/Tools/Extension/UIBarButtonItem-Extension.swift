//
//  UIBarButtonItem-Extension.swift
//  LiangDYZB
//
//  Created by qu on 2017/1/5.
//  Copyright © 2017年 qu. All rights reserved.
//

import UIKit
/*
 如果构造方法前面没有convenience单词,代表是一个初始化构造方法(指定构造方法).
 
 如果构造方法前面有convenience单词,代表是一个便利构造方法(方便构造方法).
 
 指定构造方法与便利构造方法的区别:
 
 指定构造方法中必须对所有的属性进行初始化.
 
 便利构造方法不用对所有属性进行初始化,因为便利构造方法依赖于指定构造方法(内部要调用self.init())
 
 一般情况下,想要给系统的类提供一个快速创建的方法,就自定义一个便利构造方法
 */

// 便利构造函数: 1> convenience开头 2> 在构造函数中必须明确调用一个设计的构造函数(self)
extension UIBarButtonItem{
    convenience init(imageName:String, highImageName:String  = "",size:CGSize = CGSize.zero, target: AnyObject, action: Selector){
        // 1.创建UIButton
        let btn = UIButton()
        // 2.设置btn的图片
        btn .setImage(UIImage(named:imageName), for: .normal)
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        
        // 3.设置btn的尺寸
        if size == CGSize.zero {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        btn.addTarget(target, action: action, for: .touchUpInside)

        // 4.创建UIBarButtonItem
        self.init(customView:btn)
        
    }
}
