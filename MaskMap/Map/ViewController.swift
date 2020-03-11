//
//  ViewController.swift
//  MaskMap
//
//  Created by SeongHo.Hong on 2020/03/11.
//  Copyright © 2020 Cozzin. All rights reserved.
//

import UIKit
import MapKit
import FloatingPanel

final class ViewController: UIViewController {

    private lazy var interactor: MapInteractor = {
        let presenter = MapPresenter(self)
        let interactor = MapInteractor(presenter: presenter)
        return interactor
    }()
    
    private lazy var panel = FloatingPanelController()

    private lazy var searchViewController: SearchViewController = {
        let searchViewController = SearchViewController()
        
        searchViewController.textDidBegin { [weak self] in
            self?.panel.move(to: .full, animated: true)
        }
        
        return searchViewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFloatingPanel()
    }
    
    // MARK: - Private
    
    private func setupFloatingPanel() {
        
        panel.delegate = self
        panel.set(contentViewController: searchViewController)
        panel.track(scrollView: searchViewController.scrollView)
        panel.addPanel(toParent: self)
    }

}

extension ViewController: FloatingPanelControllerDelegate {
    
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        SearchPanelLayout()
    }
    
    func floatingPanelWillBeginDragging(_ vc: FloatingPanelController) {
        _ = searchViewController.resignFirstResponder()
    }
    
}
