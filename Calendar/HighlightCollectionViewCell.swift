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
        self.layer.cornerRadius = self.frame.size.height/2
        self.addInnerShadow()
    }
    
    private func addInnerShadow() {
        let innerShadow = CALayer()
        innerShadow.frame = bounds
        // Shadow path (1pt ring around bounds)
        let path = UIBezierPath(roundedRect: innerShadow.bounds.insetBy(dx: -1, dy: -1), cornerRadius: 24)
        let cutout = UIBezierPath(rect: innerShadow.bounds).reversing()
        path.append(cutout)
        innerShadow.shadowPath = path.cgPath
        innerShadow.masksToBounds = true
        // Shadow properties
        innerShadow.shadowColor = UIColor.black.cgColor
        innerShadow.shadowOffset = CGSize(width: 0, height: 3)
        innerShadow.shadowOpacity = 0.5
        innerShadow.shadowRadius = 4
        //innerShadow.cornerRadius = self.frame.size.height/2
        blurView.layer.addSublayer(innerShadow)
    }
    
    
    @IBOutlet var blurView: UIVisualEffectView! {
        didSet {
            blurView.layer.cornerRadius = 1
            blurView.layer.masksToBounds = true
//            blurView.innerShadow()
        }
        
    }
}

extension UIView {
    func innerShadow() {
        let path = UIBezierPath(rect: CGRect(x: -5.0, y: -5.0, width: self.bounds.size.width + 5.0, height: 5.0 ))
        let innerLayer = CALayer()
        innerLayer.frame = self.bounds
        innerLayer.masksToBounds = true
        innerLayer.shadowColor = UIColor.white.cgColor
        innerLayer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        innerLayer.shadowOpacity = 0.5
        innerLayer.shadowPath = path.cgPath
        self.layer.addSublayer(innerLayer)
    }
}

