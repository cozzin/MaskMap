//
//  StorePresenter.swift
//  MaskMap
//
//  Created by SeongHo.Hong on 2020/03/12.
//  Copyright © 2020 Cozzin. All rights reserved.
//

import Foundation

final class StorePresenter {
    
    private let formatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()

    func valueConvert(_ store: Entity.Search.ViewModel.Store) -> Entity.Store.ViewModel {
        var rows: [Entity.Store.ViewModel.Row] = []
        
        rows.append(Entity.Store.ViewModel.Row(store: store, title: "장소", content: store.name))
        rows.append(Entity.Store.ViewModel.Row(store: store, title: "판매처", content: store.type.title))
        rows.append(Entity.Store.ViewModel.Row(store: store, title: "재고", content: store.remainStatus.description))
        
        if let stockDate = store.stockDate {
            let stringDate = formatter.string(from: stockDate)
            rows.append(Entity.Store.ViewModel.Row(store: store, title: "입고일", content: stringDate))
        }
        
        rows.append(Entity.Store.ViewModel.Row(store: store, title: "주소", content: store.address, rowType: .copy(store.address)))

        if canOpen(.appleMap) {
            rows.append(Entity.Store.ViewModel.Row(store: store, title: "애플지도", content: nil, rowType: .navigaiton(.appleMap)))
        }
        
        if canOpen(.kakaoMap) {
            rows.append(Entity.Store.ViewModel.Row(store: store, title: "카카오맵", content: nil, rowType: .navigaiton(.kakaoMap)))
        }
        
        if canOpen(.naverMap) {
            rows.append(Entity.Store.ViewModel.Row(store: store, title: "네이버지도", content: nil, rowType: .navigaiton(.naverMap)))
        }
        
        if canOpen(.googleMap) {
            rows.append(Entity.Store.ViewModel.Row(store: store, title: "구글지도", content: nil, rowType: .navigaiton(.googleMap)))
        }

        return Entity.Store.ViewModel(rows: rows)
    }
    
    private func canOpen(_ navigation: Entity.Store.ViewModel.Row.RowType.Navigation) -> Bool {
        navigation.canOpen
    }
    
}
