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
import CoreLocation
import MapKit

final class MapInteractor: NSObject {
    
    private let presenter: MapPresenter
    
    private lazy var delayScheduler: DelayScheduler = DelayScheduler()
    
    private lazy var canSearchByLocation: Bool = true
    
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.showsBackgroundLocationIndicator = true
        locationManager.delegate = self
        return locationManager
    }()

    init(presenter: MapPresenter) {
        self.presenter = presenter
        super.init()
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func enableSearchByLocation() {
        canSearchByLocation = true
    }
        
    func search(by location: Entity.Map.Location, visibleMapRect: Entity.Map.Rect) {
        delayScheduler.schedule { [weak self] in
            guard self?.canSearchByLocation ?? false else {
                return
            }
            
            self?.canSearchByLocation = false
            
            firstly {
                APIClient<Entity.Search.API.Request, Entity.Search.API.Response>
                    .request(
                        .storesByGeo(
                            latitude: location.latitude,
                            longitude: location.longitude,
                            rangeMeter: visibleMapRect.rangeMeter
                        )
                    )
            }.done { response in
                self?.presenter.convert(response)
            }
        }
    }
    
}

extension MapInteractor: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        
        let currentLocation = Entity.Map.Location(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude
        )

        presenter.presentCurrentPosition(currentLocation)
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
}

extension Entity.Map.Rect {
    
    enum Constant {
        static let maxRange: Int = 5000
    }
    
    fileprivate var rangeMeter: Int {
        let maxLength = max(width, height)
        let range = Int(maxLength / 2)
        return min(Constant.maxRange, range)
    }

}
