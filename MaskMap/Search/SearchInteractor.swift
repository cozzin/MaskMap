//
//  SearchInteractor.swift
//  MaskMap
//
//  Created by SeongHo.Hong on 2020/03/11.
//  Copyright © 2020 Cozzin. All rights reserved.
//

import Foundation
import PromiseKit
import ObjectMapper

final class SearchInteractor {
    
    private let presenter: SearchPresenter
    private lazy var delayScheduler: DelayScheduler = DelayScheduler()
        
    init(presenter: SearchPresenter) {
        self.presenter = presenter
    }
    
    func searchStores(address: String) {
        delayScheduler.schedule {
            let officalAddress = PostOffice.convertLongCityName(address)

            firstly {
                APIClient<Entity.Search.API.Request, Entity.Search.API.Response>
                    .request(.storesByAddress(address: officalAddress))
            }.done { response in
                self.presenter.convert(response)
            }
        }
    }
}
