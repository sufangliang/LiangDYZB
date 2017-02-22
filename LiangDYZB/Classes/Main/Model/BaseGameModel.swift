//
//  BaseGameModel.swift
//  LiangDYZB
//
//  Created by qu on 2017/2/22.
//  Copyright © 2017年 qu. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {
    var tag_name : String = ""
    var icon_url : String = ""
    
    // MARK:- 自定义构造函数
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

}
