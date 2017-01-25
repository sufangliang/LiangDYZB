//
//  PageTitleView.swift
//  LiangDYZB
//
//  Created by qu on 2017/1/10.
//  Copyright © 2017年 qu. All rights reserved.
//

import UIKit


// 代理方法
protocol pageTitleViewDelegate:class {
    func pageTitleView(_ titleView : PageTitleView, selectedIndex index : Int)
}

// 定义常量
private let kScrollLineH : CGFloat = 2
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85) //元组
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)


class PageTitleView: UIView {
    
    //定义属性
    fileprivate var titles:[String]
    fileprivate var currentIndex:NSInteger = 0
    weak  var  delegate:pageTitleViewDelegate?
    
     //懒加载
    fileprivate lazy var  titleLabels:[UILabel] = [UILabel]()
    fileprivate  lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    fileprivate var scrollLine:UIView  = {
        let  scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
        
    }()
    // MARK:- 自定义构造函数
    init(frame: CGRect,titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
        setUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//设置UI
extension PageTitleView {
    
    fileprivate func setUI (){
        //添加滑动视图
        addSubview(scrollView)
        scrollView.frame = bounds
        //添加Lab
        setUpTitleLabs()
        //添加线条
        setUpBottomLine()
    }
    
    //循环创建Lab
    fileprivate  func setUpTitleLabs() {
        
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            // 1.创建UILabel
            let label = UILabel()
            
            // 2.设置Label的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            // 3.设置label的frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            // 4.将label添加到scrollView中
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            // 5.添加手势
            let  tap = UITapGestureRecognizer(target: self, action:#selector(PageTitleView.labTapAc(sender:)))
            label.addGestureRecognizer(tap)
            label.isUserInteractionEnabled = true
         
        }
        
    }
    fileprivate func setUpBottomLine(){
        //添加线条
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH:CGFloat = 1
        bottomLine.frame = CGRect(x: 0, y: frame.height-lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        //初始化的时候选中第一个
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor.orange
        
        bottomLine.addSubview(scrollLine)
        scrollLine.frame  = CGRect(x: 0, y: 0, width: firstLabel.frame.width, height: lineH)
    }
    

    
}
//添加Lab点击方法
extension PageTitleView{
    @objc  func labTapAc(sender:UITapGestureRecognizer) {
        print("tab:%ld",sender.view!.tag)
        
        if currentIndex == sender.view!.tag {return}
        
        // 2.获取之前的Label设置颜色
        let oldLabel = titleLabels[currentIndex]
        oldLabel.textColor = UIColor.darkGray
        
        //设置当前的Lab设置选中颜色
        guard  let currentlab = sender.view as? UILabel  else{return}  //as?会尝试将值转换成给定的类型，而当这个过程不成功的时候便会返回一个nil对象
        currentlab.textColor = UIColor.orange
        
        //设置选中的线条
        UIView.animate(withDuration: 0.5) {
            self.scrollLine.center.x = currentlab.center.x
        }
        
        //记录选中的Lab
        currentIndex = sender.view!.tag
        
        
        // 判断代理是否实现
        delegate?.pageTitleView(self, selectedIndex: currentIndex)
    }

}

//MARK: 对外暴露的方法  设置选中的标题
extension PageTitleView{
    func setTitleWithProgress(progress:CGFloat,sourceIndex:Int,targetIndex:Int){
        //1.取出sourceLabel/targetLab
        let souceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        //2.处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x-souceLabel.frame.origin.x
        let moveX = moveTotalX*progress
        scrollLine.frame.origin.x = souceLabel.frame.origin.x+moveX
        
        // 3.颜色的渐变(复杂)
        // 3.1.取出变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        
        // 3.2.变化sourceLabel
        souceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        
        // 3.2.变化targetLabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        //记录最新的Index
        currentIndex = targetIndex
        
    }
}







