//
//  CollectionHeaderView.swift
//  LiangDYZB
//
//  Created by qu on 2017/2/24.
//  Copyright © 2017年 qu. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var moreBtn: UIButton!
    
    var group : AnchorGroup? {
        didSet {
            titleLab.text  = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal") //可选类型？？（双问号表示没有值时取后面的默认值）
            
        }
    }
}

extension CollectionHeaderView{
    class func collectionHeadView() -> CollectionHeaderView{
        return  Bundle.main.loadNibNamed("CollectionHeaderView", owner: nil, options: nil )?.last as! CollectionHeaderView
    }
}
