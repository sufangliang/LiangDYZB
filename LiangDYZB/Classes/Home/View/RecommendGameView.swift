//
//  RecommendGameView.swift
//  LiangDYZB
//
//  Created by qu on 2017/2/22.
//  Copyright © 2017年 qu. All rights reserved.
//

import UIKit

private let  kCelliDenty = "kCelliDenty"
class RecommendGameView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
  
    
    
     // MARK:-系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.lightGray
        collectionView.backgroundColor = UIColor.lightGray
        collectionView.dataSource = self
        collectionView.delegate =  self
       collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCelliDenty)
    
    }
    
}

//MARK: - 类方法 - 获取gameView
extension RecommendGameView{
    class  func recommendGameView() -> RecommendGameView {
        let  recommendGameView = Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
        return recommendGameView
    }
}

//MARK: - collectView 数据源
extension RecommendGameView:UICollectionViewDataSource{
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
               return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView .dequeueReusableCell(withReuseIdentifier: kCelliDenty, for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
        
    }
    
}

extension RecommendGameView:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: kGameViewH-20, height: kGameViewH-20)
    }
    

}
