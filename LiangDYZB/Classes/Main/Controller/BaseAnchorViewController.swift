//
//  BaseAnchorViewController.swift
//  LiangDYZB
//
//  Created by qu on 2017/1/24.
//  Copyright © 2017年 qu. All rights reserved.
//

import UIKit
private let kItemMargin:CGFloat =  10
private let kHeaderViewH:CGFloat =  50

private let kNormalCellID = "kNormalCellID"

private let kNormalItemW = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH = kNormalItemW * 3 / 4

class BaseAnchorViewController: BaseViewController {
    lazy var collectionView:UICollectionView = {
        // 创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize  = CGSize(width: kScreenW, height: kHeaderViewH)
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        //        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        
        return collectionView
    }()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        
    }
    
    
}

extension BaseAnchorViewController{
    override func setupUI() {
        
        
    }
   }
 //MARK: - collectView 数据源
extension BaseAnchorViewController:UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView .dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        return cell

    }
    
}
