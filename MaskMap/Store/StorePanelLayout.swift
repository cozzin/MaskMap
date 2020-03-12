//
//  StorePanelLayout.swift
//  MaskMap
//
//  Created by SeongHo.Hong on 2020/03/11.
//  Copyright © 2020 Cozzin. All rights reserved.
//

import Foundation
import FloatingPanel

final class StorePanelLayout: FloatingPanelLayout {
    
    init() { }

    var initialPosition: FloatingPanelPosition {
        .half
    }
    
    var supportedPositions: Set<FloatingPanelPosition> {
        [.full, .half]
    }
    
    public func insetFor(position: FloatingPanelPosition) -> CGFloat? {
        switch position {
        case .full: return 18.0
        case .half: return 262.0
        case .tip: return 69.0
        case .hidden: return nil
        }
    }
}
