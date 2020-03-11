//
//  StoreEntity.swift
//  MaskMap
//
//  Created by SeongHo.Hong on 2020/03/11.
//  Copyright © 2020 Cozzin. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper
import MapKit

extension Entity {
    enum Map {
        struct Location {
            let latitude: Double
            let longitude: Double
            
            func asCoordination() -> CLLocationCoordinate2D {
                CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            }
        }
        
        struct Rect {
            let width: Double
            let height: Double
        }
        
        enum CurrentPosition {
            struct ViewModel {
                let location: Entity.Map.Location
                
                var coordination: CLLocationCoordinate2D {
                    location.asCoordination()
                }
            }
        }
    }
}
