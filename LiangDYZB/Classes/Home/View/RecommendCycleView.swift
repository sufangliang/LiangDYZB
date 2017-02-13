//
//  RecommendCycleView.swift
//  LiangDYZB
//
//  Created by qu on 2017/1/19.
//  Copyright © 2017年 qu. All rights reserved.
//
/*        
 Swift - 属性观察者（willSet与didSet）
 属性观察者，类似于触发器。用来监视属性的除初始化之外的属性值变化，当属性值发生改变时可以对此作出响应。有如下特点：
 1，不仅可以在属性值改变后触发didSet，也可以在属性值改变前触发willSet。
 2，给属性添加观察者必须要声明清楚属性类型，否则编译器报错。
 3，willSet可以带一个newName的参数，没有的话，该参数默认命名为newValue。
 4，didSet可以带一个oldName的参数，表示旧的属性，不带的话默认命名为oldValue。
 5，属性初始化时，willSet和didSet不会调用。只有在初始化上下文之外，当设置属性值时才会调用。
 6，即使是设置的值和原来值相同，willSet和didSet也会被调用
 */

import UIKit

private let kCycleCellID = "kCycleCellID"
class RecommendCycleView: UIView {
     // MARK:-定义属性
    var cycleTimer : Timer?
    var cycleModes:[CycleModel]? {
        didSet{
            collectionView .reloadData()
        }
    
    }
    
    
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
        
        return (cycleModes?.count ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  =   collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionCycleCell
        cell.cycleModel = cycleModes?[indexPath.item]
        cell.contentView.backgroundColor = UIColor.blue
        return cell
    }
    
}
