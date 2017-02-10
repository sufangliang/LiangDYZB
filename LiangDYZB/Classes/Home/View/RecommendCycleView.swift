//
//  RecommendCycleView.swift
//  LiangDYZB
//
//  Created by qu on 2017/1/19.
//  Copyright © 2017年 qu. All rights reserved.
//

import UIKit

private let kCycleCellID = "kCycleCellID"
class RecommendCycleView: UIView {
    
    var cycleTimer : Timer?

    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        
        //注册cell
        let nib = UINib(nibName: "CollectionCycleCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: kCycleCellID)
        
        //设置collectionView的layout
        /*
         as！(相当于强转) 强转如果类型不符合会报错
         as? 相当于optional类型，如果转换失败返回nil。
         */
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize  = collectionView.bounds.size
        //设置cell横向滑动
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal

    }
}

extension RecommendCycleView{
    class  func recommendCycleView() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.last as! RecommendCycleView
    }
}

extension RecommendCycleView:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  =   collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionCycleCell
        cell.contentView.backgroundColor = UIColor.blue
        return cell
    }
    
}
