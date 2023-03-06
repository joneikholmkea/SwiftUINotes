//
//  Location.swift
//  SwiftUIFirebase
//
//  Created by Jon Eikholm on 02/03/2023.
//

import Foundation
import MapKit
struct Location: Identifiable {
    let id = UUID()
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
            CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
}
