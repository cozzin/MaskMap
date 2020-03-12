//
//  File.swift
//  MaskMap
//
//  Created by SeongHo.Hong on 2020/03/12.
//  Copyright © 2020 Cozzin. All rights reserved.
//

import UIKit

extension Entity.Store {
    
    struct ViewModel {
        struct Row {
            enum RowType {
                enum Navigation {
                    case appleMap
                    case naverMap
                    case kakaoMap
                    
                    var canOpen: Bool {
                        switch self {
                        case .naverMap:
                            return UIApplication.shared.canOpenURL(URL(string: "nmap://")!)
                        case .kakaoMap:
                            return UIApplication.shared.canOpenURL(URL(string: "kakaomap://")!)
                        case .appleMap:
                            return true
                        }
                    }
                }
                
                case normal
                case copy(String)
                case navigaiton(Navigation)
            }
            
            let title: String
            let content: String?
            let rowType: RowType
            let store: Entity.Search.ViewModel.Store
            
            init(store: Entity.Search.ViewModel.Store, title: String, content: String?, rowType: RowType = .normal) {
                self.store = store
                self.title = title
                self.content = content
                self.rowType = rowType
            }
        }
        
        let rows: [Row]
    }
    
}
