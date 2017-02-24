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
private let KPrettyCellID = "CollectionPrettyCell"
private let kHeaderViewID = "kHeaderViewID"

private let kNormalItemW = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH = kNormalItemW * 3 / 4
private let kPrettyItemH = kNormalItemW * 4 / 3


class BaseAnchorViewController: BaseViewController {
    // MARK: 定义属性
    var baseVM : RecommendViewModel!

    lazy var collectionView:UICollectionView = {
        // 创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0  //
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize  = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)//调整左右间隙都为10
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: KPrettyCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)

        return collectionView
    }()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()

    }
    
}

extension BaseAnchorViewController{
     override func setupUI() {
        
        
        // 2.添加collectionView
        view.addSubview(collectionView)
        
        // 3.调用super.setupUI()
        super.setupUI()

    }
   }
 //MARK: - collectView 数据源
extension BaseAnchorViewController:UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        print("共有多少组\( baseVM.anchorGroups.count)")
        return baseVM.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
              return baseVM.anchorGroups[section].anchors.count
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let cell = collectionView .dequeueReusableCell(withReuseIdentifier: KPrettyCellID, for: indexPath) as! CollectionPrettyCell
            let anchor  = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            cell.anchor = anchor
            return cell
        }
        let cell = collectionView .dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)  as! CollectionNormalCell
        let anchor  = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        cell.anchor = anchor
        return cell

    }
    //组头视图
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        headView.group = baseVM.anchorGroups[indexPath.section];
        return headView
    }
    
}

extension BaseAnchorViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }

}
