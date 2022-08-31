//
//  ToyShape.swift
//  Calendar

//  Created by 鈴木　葵葉 on 2021/07/28.
//

import UIKit

struct ToyShape: Identifiable {
    var color: String
    let type: String
    let count: Int
    let id = UUID()
}

enum ConcentrationType: String {
    case normal =  "charts-lightblue"
    case concentrating = "charts-blue"
    case superConcentrating = "charts-deepblue"
}
