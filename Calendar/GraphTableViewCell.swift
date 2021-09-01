//
//  GraphTableViewCell.swift
//  PictogramSamplw
//
//  Created by Masakaz Ozaki on 2021/05/12.
//

import UIKit

class GraphTableViewCell: UITableViewCell {
    @IBOutlet var graphView: UIView!

    // width should be between 0.0 to 1.0
    var width: CGFloat = 0.5 {
        didSet {
            guard let graphView = graphView else { return }
            graphView.widthAnchor.constraint(equalToConstant: width * self.frame.width).isActive = true
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
