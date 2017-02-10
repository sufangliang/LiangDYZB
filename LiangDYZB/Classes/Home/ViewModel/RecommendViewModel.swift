//
//  RecommendViewModel.swift
//  LiangDYZB
//
//  Created by qu on 2017/2/10.
//  Copyright © 2017年 qu. All rights reserved.
//

import UIKit

class RecommendViewModel: NSObject {

}

//MARK - 发送网络请求
extension RecommendViewModel{
    func requestData(_finshCallback:@escaping () -> ()) {
        //定义参数
        let parameters = ["limit":"4","offset" : "0", "time" : Date.getCurrentTime()]
        
        // 2.创建Group
        let dGroup = DispatchGroup()
        
        // 3.请求第一部分推荐数据
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : Date.getCurrentTime()]) { (result) in
            guard let resultDict = result as?[String:NSObject] else{return}
            
            print("haha\(resultDict)")
            
            
        }
    }
    
    
    // 请求无线轮播的数据
    func requestCycleData(_ finishCallback : @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"]) { (result) in
            // 1.获取整体字典数据
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根据data的key获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 3.字典转模型对象
            for dict in dataArray {
                self.cycleModels.append(CycleModel(dict: dict))
            }
            
            finishCallback()
        }
    }

}
