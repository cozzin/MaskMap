//
//  SearchPanelLayout.swift
//  MaskMap
//
//  Created by SeongHo.Hong on 2020/03/11.
//  Copyright © 2020 Cozzin. All rights reserved.
//

import Foundation
import FloatingPanel

final class SearchPanelLayout: FloatingPanelLayout {
    public init() { }

    public var initialPosition: FloatingPanelPosition {
        return .tip
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
