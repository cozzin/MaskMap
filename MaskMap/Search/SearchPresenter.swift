//
//  SearchPresenter.swift
//  MaskMap
//
//  Created by SeongHo.Hong on 2020/03/11.
//  Copyright © 2020 Cozzin. All rights reserved.
//

import Foundation

final class SearchPresenter {
    
    private unowned let viewController: SearchViewController
    
    init(_ viewController: SearchViewController) {
        self.viewController = viewController
    }
    
    func convert(_ response: Entity.Search.API.Response) {
        let stores = response.stores.map {
            Entity.Search.ViewModel.Store(
                name: $0.name,
                address: $0.address,
                type: $0.type,
                location: $0.location,
                stockDate: $0.stockDate,
                remainStatus: $0.remainStatus
            )
        }
        let filterdStores = stores.filter { $0.isOnSale }.sorted { $0.priority < $1.priority }
        let viewModel = Entity.Search.ViewModel(stores: filterdStores)

        DispatchQueue.main.async { [weak self] in
            self?.viewController.updateUI(viewModel)
        }
    }
    
}
