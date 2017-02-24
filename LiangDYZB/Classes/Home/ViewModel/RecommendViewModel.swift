//
//  RecommendViewModel.swift
//  LiangDYZB
//
//  Created by qu on 2017/2/10.
//  Copyright © 2017年 qu. All rights reserved.
//

import UIKit

class RecommendViewModel: NSObject {
    // MARK:- 懒加载属性
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()  //分组的主播数组

    lazy var cycleModels : [CycleModel] = [CycleModel]()
    fileprivate lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyGroup :AnchorGroup =  AnchorGroup()

}

//MARK - 发送网络请求
extension RecommendViewModel{
    func requestData(_ finshCallback:@escaping () -> ()) {
        //定义参数
        let parameters = ["limit":"4","offset" : "0", "time" : Date.getCurrentTime()]

        // 2.创建Group
        let dGroup = DispatchGroup()
        
        // 3.请求第一部分推荐数据
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : Date.getCurrentTime()]) { (result) in
            // 1.将result转成字典类型
            guard let resultDict = result as?[String:NSObject] else{return}
            print("推荐数据\(resultDict)")
            
            // 2.根据data该key,获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 3.遍历字典，并且转成模型对象
            // 3.1 设置组的属性
            
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            for dict in dataArray{
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            // 3.3.离开组
            dGroup.leave()
        }
        
        
        // 4.请求第二部分颜值数据
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根据data该key,获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 3.遍历字典,并且转成模型对象
            // 3.1.设置组的属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            
            // 3.2.获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            
            // 3.3.离开组
            dGroup.leave()

        }
        
        
        NetworkTools.requestData(.get, URLString:"http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
            // 1.对界面进行处理
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            // 2.判断是否分组数据
                // 2.1.遍历数组中的字典
                for dict in dataArray {
                    self.anchorGroups.append(AnchorGroup(dict: dict))
            }
       
        }
        
        // 6.所有的数据都请求到,之后进行排序
        dGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finshCallback()
        }

    }
    
    // 请求无线轮播的数据
    func requestCycleData(_ finishCallback : @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"]) { (result) in
            print("轮播数据\(result)")

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
