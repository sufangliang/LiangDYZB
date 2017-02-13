//
//  RecommendViewController.swift
//  LiangDYZB
//
//  Created by qu on 2017/1/12.
//  Copyright © 2017年 qu. All rights reserved.
//

import UIKit
private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90

class RecommendViewController: BaseViewController {

    // MARK:- 懒加载属性
    fileprivate lazy var recommendVM : RecommendViewModel = RecommendViewModel()

    
    fileprivate lazy var  cycleView : RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kCycleViewH)
        cycleView.backgroundColor = UIColor.lightGray
        return  cycleView
        
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.blue
        
        setupUI()
        
        loaddata()  
    }

   }


// MARK - 设置UI
extension RecommendViewController{
    override func setupUI() {
        super.setupUI()
        
        view .addSubview(cycleView)
    }
    
}


// MARK - 设置UI
extension RecommendViewController{
    func loaddata() {
        // 1.请求推荐数据
        recommendVM.requestData {
            
        }
        
        
        // 2.请求轮播数据
        recommendVM.requestCycleData {
            self.cycleView.cycleModes = self.recommendVM.cycleModels
            
        }
   
   
    }
    
}
