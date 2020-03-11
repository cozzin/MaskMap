//
//  MapInteractor.swift
//  MaskMap
//
//  Created by SeongHo.Hong on 2020/03/11.
//  Copyright © 2020 Cozzin. All rights reserved.
//

import Foundation
import PromiseKit
import ObjectMapper

final class MapInteractor {
    
    private let presenter: MapPresenter
        
    init(presenter: MapPresenter) {
        self.presenter = presenter
    }
}
