//
//  StoreAnnotation.swift
//  MaskMap
//
//  Created by SeongHo.Hong on 2020/03/11.
//  Copyright © 2020 Cozzin. All rights reserved.
//

import Foundation
import MapKit

final class StoreAnnotation: NSObject, MKAnnotation {
    
    let title: String?
    let address: String
    let coordinate: CLLocationCoordinate2D
    
    var tintColor: UIColor {
        remainStatus.tintColor
    }
    
    var subtitle: String? {
        return remainStatus.description
    }
    
    private let remainStatus: Entity.Store.RemainStatus
    
    init(_ store: Entity.Search.ViewModel.Store) {
        self.title = store.name
        self.address = store.address
        self.remainStatus = store.remainStatus
        self.coordinate = store.location.asCoordination()
        super.init()
    }
}
