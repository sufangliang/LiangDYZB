//
//  CollectionCycleCell.swift
//  LiangDYZB
//
//  Created by qu on 2017/1/24.
//  Copyright © 2017年 qu. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionCycleCell: UICollectionViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titleLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var cycleModel : CycleModel?{
        didSet{
            titleLab.text = cycleModel?.title
            
            let url  = URL(string: cycleModel?.pic_url ?? "")!
           
            img.kf.setImage(with: url, placeholder:  UIImage(named: "Img_default"))
        }
    }
    
    
    
}
