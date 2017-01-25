//
//  HomeViewController.swift
//  LiangDYZB
//
//  Created by qu on 2017/1/5.
//  Copyright © 2017年 qu. All rights reserved.
//

import UIKit
private let KtitleViewH:CGFloat = 40

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        //设置UI
        setUI()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    fileprivate lazy var pageTitleView:PageTitleView = {
        let titleFrame = CGRect(x: 0, y: kNavigationTotalH, width: kScreenW, height: KtitleViewH)
        let titleView = PageTitleView(frame: titleFrame, titles: ["推荐", "游戏", "娱乐", "趣玩",])
        return titleView
    }()
    
    fileprivate lazy var contentView:PageContentView = {
        let vc1:RecommendViewController = RecommendViewController()
        let vc2:GameViewController = GameViewController()
        let vc3:AmuseViewController = AmuseViewController()
        let vc4:FunnyViewController = FunnyViewController()
        let arrVcs = [vc1,vc2,vc3,vc4]
        
        let contentRect = CGRect(x: 0, y: KtitleViewH+kNavigationTotalH, width: kScreenW, height: kScreenH-kNavigationTotalH-KtitleViewH-kTabbarH)
      let   contentView = PageContentView(frame: contentRect, childVcs: arrVcs, parentVc: self)
        return contentView
    }()

}

extension HomeViewController{
    func setUI() {
        // 0.不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false  //不加上这行 将导致看不到子视图
        // 1.设置导航栏
        setupNavigationBar()
        
        // 2.添加TitleView
        view.addSubview(pageTitleView)
        //TitleView 设置点击事件的代理
        pageTitleView.delegate =  self
        //pageContentView 设置代理
        contentView.delegate = self
        //添加contentView
        view.addSubview(contentView)
        
        
    }
    
    //设置左边按钮
      func setupNavigationBar() {
        let leftImg = UIImage(named: "logo")
        let item1=UIBarButtonItem(image: leftImg, style: UIBarButtonItemStyle.plain, target: self, action:#selector(HomeViewController.leftAc))
        self.navigationItem.leftBarButtonItem=item1
        
        // 2.设置右侧的Item
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size, target: self, action: #selector(HomeViewController.leftAc))
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size, target: self, action: #selector(HomeViewController.leftAc))
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size, target: self, action: #selector(HomeViewController.leftAc))
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
        
        
         
    }
    func  leftAc() {
        print("左边按钮或者右边被点击")
    }
    
    
}
//MARK: titleView 代理
extension HomeViewController:pageTitleViewDelegate{
    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int) {
        self.contentView.setcurrentIndex(currentIndex: index)
    }

}

//MARK:contentView代理
extension HomeViewController:PageContentViewDelegate{
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView .setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
