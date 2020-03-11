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
    
    func convert(_ response: Entity.Search.StoresByAddress.API.Response) {
        let stores = response.stores.map {
            Entity.Search.StoresByAddress.ViewModel.Store(
                name: $0.name,
                address: $0.address,
                type: $0.type,
                location: $0.location,
                stockDate: $0.stockDate,
                remainStatus: $0.remainStatus
            )
        }
        let viewModel = Entity.Search.StoresByAddress.ViewModel(stores: stores)

        DispatchQueue.main.async { [weak self] in
            self?.viewController.updateUI(viewModel)
        }
    }
    
}
