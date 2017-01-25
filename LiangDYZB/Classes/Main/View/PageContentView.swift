//
//  PageContentView.swift
//  LiangDYZB
//
//  Created by qu on 2017/1/12.
//  Copyright © 2017年 qu. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    func pageContentView(_ contentView : PageContentView, progress : CGFloat, sourceIndex : Int, targetIndex : Int)
}

private  let  identycollectCell = "collectCell"

class PageContentView: UIView {
    //MARK:- 定义属性
    fileprivate var  childVcs:[UIViewController]
    fileprivate var  parentVc:UIViewController
    fileprivate var startOffsetX:CGFloat = 0
    fileprivate var isForbidScrollDelegate : Bool = false
    weak var delegate:PageContentViewDelegate?
    
    fileprivate lazy var colletctView:UICollectionView = {
        //创建布局对象 
        let layout = UICollectionViewFlowLayout()
        layout.itemSize  =  self.frame.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //创建collectView 
        let collectView = UICollectionView(frame:CGRect.zero, collectionViewLayout: layout)
        collectView.backgroundColor  = UIColor.lightGray
        collectView.isPagingEnabled = true
        collectView.bounces = false
        collectView.dataSource = self
        collectView.delegate = self
        collectView.scrollsToTop = false
        collectView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: identycollectCell)
        return collectView
    }()
    
    //初始化创建View
    init(frame: CGRect,childVcs:[UIViewController],parentVc:UIViewController) {
        self.childVcs  = childVcs   // 属性初始化 必须在super.init 之前
        self.parentVc = parentVc
        super.init(frame: frame)

        setUI()
    }
  required  init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//设置UI
extension PageContentView{
    func setUI(){
        for  childVc in childVcs {
            self.parentVc.addChildViewController(childVc)
        }
        addSubview(colletctView)
        colletctView.frame = bounds
    }
}

//MARK: - collectView 代理
extension PageContentView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView .dequeueReusableCell(withReuseIdentifier: identycollectCell, for: indexPath)
        for view in cell.contentView.subviews {
            view .removeFromSuperview()
        }
        let  childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView .addSubview(childVc.view)
        
        //随机色
//        let red = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
//        let green = CGFloat( arc4random_uniform(255))/CGFloat(255.0)
//        let blue = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
//        let colorRun = UIColor.init(red:red, green:green, blue:blue , alpha: 1)
//        cell.contentView.backgroundColor = colorRun
        return cell
    }
    
}

//MARK: - contentView - 滑动代理
extension PageContentView:UICollectionViewDelegate{
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false

        startOffsetX = scrollView.contentOffset.x
        print("startOffsetX:%f",startOffsetX)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 0.判断是否是点击事件
        if isForbidScrollDelegate { return }
        
        // 1.定义获取需要的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        // 2.判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX { // 左滑
            // 1.计算progress    floor 最大整数
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            // 2.计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            
            // 3.计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            print("\(currentOffsetX)")
            // 4.如果完全划过去
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        } else { // 右滑
            // 1.计算progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            // 2.计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            // 3.计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
        
        // 3.将progress/sourceIndex/targetIndex传递给titleView
        delegate?.pageContentView(self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }

}

//设置page的当前页
extension PageContentView {
    func setcurrentIndex (currentIndex:NSInteger){
        // 1.记录需要进制执行代理方法
        isForbidScrollDelegate = true

        // 2.滚动正确的位置
        let offsetX = CGFloat (currentIndex)*colletctView.frame.width
        colletctView.setContentOffset(CGPoint(x:offsetX,y:0), animated: true)
    }
    
}






