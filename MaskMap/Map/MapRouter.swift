//
//  MapRouter.swift
//  MaskMap
//
//  Created by SeongHo.Hong on 2020/03/12.
//  Copyright © 2020 Cozzin. All rights reserved.
//

import Foundation
import FloatingPanel

final class MapRouter: NSObject {
    
    private unowned let viewController: ViewController
    
    init(_ viewController: ViewController) {
        self.viewController = viewController
    }
    
    func presentStoreViewController(_ store: Entity.Search.ViewModel.Store) {
        let panel: FloatingPanelController = FloatingPanelController()
        let storeViewController: StoreViewController = StoreViewController(store)

        panel.delegate = self
        panel.isRemovalInteractionEnabled = true
        panel.set(contentViewController: storeViewController)
        panel.track(scrollView: storeViewController.scrollView)
        
        viewController.present(panel, animated: true)
    }
    
}

extension MapRouter: FloatingPanelControllerDelegate {

    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        StorePanelLayout()
    }

}
