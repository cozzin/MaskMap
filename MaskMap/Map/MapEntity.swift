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

extension Entity {
    enum Map {
        struct Location {
            let latitude: Double
            let longitude: Double
        }
    }
}
