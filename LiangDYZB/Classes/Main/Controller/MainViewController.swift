//
//  MainViewController.swift
//  LiangDYZB
//
//  Created by qu on 2017/1/5.
//  Copyright © 2017年 qu. All rights reserved.
//1.。1.11111

/*  在原有的swift中的 private其实并不是真正的私有，如果一个变量定义为private，在同一个文件中的其他类依然是可以访问到的。这个场景在使用extension的时候很明显。
 由此，在swift 3中，新增加了一个 fileprivate来显式的表明，这个元素的访问权限为文件内私有。过去的private对应现在的fileprivate。现在的private则是真正的私有，离开了这个类或者结构体的作用域外面就无法访问。
 */

import UIKit


class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        }
 
}
