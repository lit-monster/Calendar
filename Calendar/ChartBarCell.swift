//
//  ChartBarCell.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2021/11/10.
//

import UIKit

class ChartBarCell: UICollectionViewCell {
    @IBOutlet weak var dayLabel: UILabel!
    
    override func prepareForReuse() {
        contentView.backgroundColor = UIColor(named: "n")!
    }
    
    func setText(_ text: String?) {
        dayLabel.text = text
    }
    
    func setBackgroundColor(_ color: UIColor) {
        contentView.backgroundColor = color
    }
}
