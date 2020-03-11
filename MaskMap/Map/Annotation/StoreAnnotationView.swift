//
//  StoreAnnotationView.swift
//  MaskMap
//
//  Created by SeongHo.Hong on 2020/03/11.
//  Copyright © 2020 Cozzin. All rights reserved.
//

import Foundation
import MapKit

final class StoreAnnotationView: MKMarkerAnnotationView {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        markerTintColor = .white
        glyphText = nil
    }
    
    func configure(_ storeAnnotation: StoreAnnotation) {
        canShowCallout = true
        calloutOffset = CGPoint(x: -5, y: 5)
        
        markerTintColor = storeAnnotation.tintColor
        glyphText = storeAnnotation.title
    }
    
}
