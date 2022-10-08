//
//  IdentifiablePlace.swift
//  Calendar
//
//  Created by 鈴木　葵葉 on 2022/10/09.
//

import Foundation
import CoreLocation

struct IdentifiablePlace: Identifiable {
    let id: UUID
    let location: CLLocationCoordinate2D
    init(id: UUID = UUID(), lat: Double, long: Double) {
        self.id = id
        self.location = CLLocationCoordinate2D(
            latitude: lat,
            longitude: long)
    }
}
