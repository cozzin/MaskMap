//
//  AnnotationRegister.swift
//  MaskMap
//
//  Created by SeongHo.Hong on 2020/03/11.
//  Copyright © 2020 Cozzin. All rights reserved.
//

import Foundation
import MapKit

extension MKAnnotationView {
    static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
}

extension MKMapView {
    
    public func register<T>(_ annotationClass: T.Type) where T: MKAnnotationView {
        register(annotationClass, forAnnotationViewWithReuseIdentifier: annotationClass.reuseIdentifier)
    }
    
    public func dequeue<T>(for annotation: MKAnnotation) -> T where T: MKAnnotationView {
        guard let view = dequeueReusableAnnotationView(withIdentifier: T.reuseIdentifier, for: annotation) as? T else {
                fatalError(
                    "Error: view with id: \(T.reuseIdentifier) for annotation: \(annotation) is not \(T.self)")
        }
        
        return view
    }
    
}
