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
    
    private weak var panel: FloatingPanelController?
    
    init(_ viewController: ViewController) {
        self.viewController = viewController
    }
    
    func presentStoreViewController(_ store: Entity.Search.ViewModel.Store) {
        let panel: FloatingPanelController = FloatingPanelController()

        panel.surfaceView.cornerRadius = 9.0
        panel.surfaceView.backgroundColor = .systemBackground
        panel.delegate = self
        panel.isRemovalInteractionEnabled = true

        let storeViewController: StoreViewController = StoreViewController(store)
        panel.set(contentViewController: storeViewController)
        panel.track(scrollView: storeViewController.scrollView)
        
        if let existingPanel = self.panel {
            existingPanel.dismiss(animated: true, completion: { [weak self] in
                self?.viewController.present(panel, animated: true)
                self?.panel = panel
            })
        } else {
            viewController.present(panel, animated: true)
            self.panel = panel
        }
    }
    
}

extension MapRouter: FloatingPanelControllerDelegate {

    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        StorePanelLayout()
    }

}
