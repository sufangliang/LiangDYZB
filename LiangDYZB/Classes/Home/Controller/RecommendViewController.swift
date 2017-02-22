//
//  RecommendViewController.swift
//  LiangDYZB
//
//  Created by qu on 2017/1/12.
//  Copyright © 2017年 qu. All rights reserved.
//

import UIKit
private let kCycleViewH = kScreenW * 3 / 8
let kGameViewH : CGFloat = 90

class RecommendViewController: BaseAnchorViewController {

    // MARK:- 懒加载属性
    fileprivate lazy var recommendVM : RecommendViewModel = RecommendViewModel()

     // MARK:- 轮播图
    fileprivate lazy var  cycleView : RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH+kGameViewH), width: kScreenW, height: kCycleViewH)
        cycleView.backgroundColor = UIColor.lightGray
        return  cycleView
        
    }()
    
     // MARK:- 轮播图下方的可横向滚动的游戏视图
    fileprivate lazy var gameView :RecommendGameView = {
        let  gameView =  RecommendGameView.recommendGameView()
        gameView.frame =  CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
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
        
     
        collectionView .addSubview(cycleView)   //添加轮播图
        collectionView .addSubview(gameView)   //添加轮播图下方游戏视图
        collectionView.contentInset = UIEdgeInsetsMake(kCycleViewH+kGameViewH, 0, 0, 0)//设置collectionView的内边距
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
