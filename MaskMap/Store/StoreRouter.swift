//
//  StoreRouter.swift
//  MaskMap
//
//  Created by SeongHo.Hong on 2020/03/12.
//  Copyright © 2020 Cozzin. All rights reserved.
//

import UIKit
import MapKit

final class StoreRouter {
    
    private unowned let viewController: StoreViewController
    
    init(_ viewController: StoreViewController) {
        self.viewController = viewController
    }
    
    func presentActivity(_ content: String) {
        let activityViewController = UIActivityViewController(activityItems: [content], applicationActivities: nil)
        
        viewController.present(activityViewController, animated: true)
    }
    
    func routeNavigation(_ navigationType: Entity.Store.ViewModel.Row.RowType.Navigation, store: Entity.Search.ViewModel.Store) {
        
        let location = store.location
        
        switch navigationType {
        case .appleMap:
            let placemark = MKPlacemark(coordinate: location.asCoordination(), addressDictionary: nil)
            let launchOptions = [
                MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
            ]

            MKMapItem.openMaps(with: [MKMapItem.forCurrentLocation(), MKMapItem(placemark: placemark)], launchOptions: launchOptions)
        case .googleMap:
            let url = URL(string:
            "comgooglemaps://?saddr=&daddr=\(location.latitude),\(location.longitude)&directionsmode=driving")!
            
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        case .kakaoMap:
            let url = URL(string: "kakaomap://look?p=\(location.latitude),\(location.longitude)")!
            
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        case .naverMap:
            // https://docs.ncloud.com/ko/naveropenapi_v3/maps/url-scheme/url-scheme.html
            let bundleId = Bundle.main.bundleIdentifier ?? "com.cozzin.MaskMap"
            let url = URL(string: "nmap://place?lat=\(location.latitude)&lng=\(location.longitude)&name=\(store.name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? store.name)&appname=\(bundleId)")!
            
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
}
