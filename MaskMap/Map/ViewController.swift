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
import ISHHoverBar

final class ViewController: UIViewController {

    private lazy var interactor: MapInteractor = {
        let presenter = MapPresenter(self)
        let interactor = MapInteractor(presenter: presenter)
        return interactor
    }()
    
    private lazy var router: MapRouter = MapRouter(self)
    
    private lazy var panel: FloatingPanelController = {
        let panel: FloatingPanelController = FloatingPanelController()
        panel.surfaceView.backgroundColor = .systemBackground
        return panel
    }()
    
    private lazy var searchViewController: SearchViewController = {
        let searchViewController = SearchViewController()
        
        searchViewController.textDidBegin { [weak self] in
            self?.panel.move(to: .full, animated: true)
        }
        searchViewController.didTapStore { [weak self] searchResult, store in
            self?.addAnnotations(searchResult)
            self?.moveMapPostion(at: store.location)
            self?.panel.move(to: .tip, animated: true)
            self?.router.presentStoreViewController(store)
        }
        
        return searchViewController
    }()
    
    private lazy var mapView: MKMapView = {
        let mapView: MKMapView = MKMapView()
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.showsTraffic = true
        mapView.showsBuildings = true
        mapView.register(StoreAnnotationView.self)
        return mapView
    }()
    
    private lazy var hoverBar: ISHHoverBar = {
        let hoverBar: ISHHoverBar = ISHHoverBar()
        let trackingItem = MKUserTrackingBarButtonItem(mapView: mapView)
        hoverBar.items = [trackingItem]
        return hoverBar
    }()
    
    private lazy var infoView: InfoView = {
        let infoView: InfoView = InfoView()
        return infoView
    }()
      
    private lazy var userTrackingButton: MKUserTrackingButton = MKUserTrackingButton(mapView: mapView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mapView)
        view.addSubview(hoverBar)
        view.addSubview(infoView)
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        infoView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40.0)
            $0.leading.equalToSuperview().inset(10.0)
            $0.height.equalTo(120.0)
            $0.width.equalTo(150.0)
        }
        hoverBar.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40.0)
            $0.trailing.equalToSuperview().inset(20.0)
        }
        
        interactor.startUpdatingLocation()
        setupFloatingPanel()
    }
    
    func updateUI(_ viewModel: Entity.Search.ViewModel) {
        addAnnotations(viewModel)
        searchViewController.updateUI(viewModel)
    }
    
    func updateUI(_ viewModel: Entity.Map.CurrentPosition.ViewModel) {
        let center = CLLocationCoordinate2D(
            latitude: viewModel.location.latitude,
            longitude: viewModel.location.longitude
        )
        let region = MKCoordinateRegion(
            center: center,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
        mapView.setRegion(region, animated: true)
    }
    
    // MARK: - Private
    
    private func setupFloatingPanel() {
        panel.delegate = self
        panel.set(contentViewController: searchViewController)
        panel.track(scrollView: searchViewController.scrollView)
        panel.addPanel(toParent: self)
    }
    
    private func addAnnotations(_ viewModel: Entity.Search.ViewModel) {
        let annotations = viewModel.stores.map { StoreAnnotation($0) }
        
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(annotations)
    }
        
    private func moveMapPostion(at location: Entity.Map.Location) {
        let regionRadius: CLLocationDistance = 100
        let coordinateRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude),
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius
        )
        
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @objc
    private func didTapInfoButton(_ sender: UIButton) {
        interactor.startUpdatingLocation()
    }

}

extension ViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? StoreAnnotation else {
            return nil
        }
        
        let view = mapView.dequeue(for: annotation) as StoreAnnotationView
        view.configure(annotation)
        return view
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let storeAnnotationView = view as? StoreAnnotationView,
            let storeAnnotation = storeAnnotationView.storeAnnotation else {
                return
        }
        
        router.presentStoreViewController(storeAnnotation.store)
    }
        
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        let coordinator = Entity.Map.Location(
            latitude: mapView.centerCoordinate.latitude,
            longitude: mapView.centerCoordinate.longitude
        )
        let visibleMapRect = Entity.Map.Rect(
            width: mapView.visibleMapRect.width,
            height: mapView.visibleMapRect.height
        )
        
        interactor.search(by: coordinator, visibleMapRect: visibleMapRect)
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
