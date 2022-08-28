//
//  HighlightCollectionViewCell.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2022/04/04.
//

import UIKit

class HighlightCollectionViewCell: UICollectionViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        super.layoutSubviews()
    }
    
    @IBOutlet var blurView: UIVisualEffectView! {
        didSet {
            blurView.layer.cornerRadius = 1
            blurView.layer.masksToBounds = true
            //            blurView.innerShadow()
        }
        
    }
}
