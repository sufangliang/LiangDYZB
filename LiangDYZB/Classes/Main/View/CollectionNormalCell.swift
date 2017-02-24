//
//  CollectionNormalCell.swift
//  LiangDYZB
//
//  Created by qu on 2017/2/21.
//  Copyright © 2017年 qu. All rights reserved.
//

import UIKit

class CollectionNormalCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var onlineBtn: UIButton!
    
    @IBOutlet weak var nickNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var anchor : AnchorModel? {
        didSet {
            guard let anchor = anchor  else {return }   //校验之后，后面写anchor  就不要写成可选类型了
            // 1.取出在线人数显示的文字
            var onlineStr : String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            } else {
                onlineStr = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            
            //昵称
            nickNameLabel.text = anchor.nickname
            
            // 3.设置封面图片
            guard let iconURL = URL(string: anchor.vertical_src) else { return }
            iconImageView.kf.setImage(with: iconURL)

        }
    }
    
}
