//
//  Entity.swift
//  MaskMap
//
//  Created by SeongHo.Hong on 2020/03/11.
//  Copyright © 2020 Cozzin. All rights reserved.
//

import UIKit

enum Entity { }

extension Entity {
    enum API {
        static let baseURL: URL = URL(string: "https://8oi9s0nnth.apigw.ntruss.com/corona19-masks/v1")!
    }
}

extension Entity {
    enum Store {
        enum StoreType: String {
            case pharmacy = "01"
            case postOffice = "02"
            case nonghyup = "03"
            
            var title: String {
                switch self {
                case .pharmacy:
                    return "약국"
                case .postOffice:
                    return "우체국"
                case .nonghyup:
                    return "농협"
                }
            }
        }
        
        /// 재고 상태[100개 이상(녹색): 'plenty' / 30개 이상 100개미만(노랑색): 'some' / 2개 이상 30개 미만(빨강색): 'few' / 1개 이하(회색): 'empty']
        enum RemainStatus: String {
            case plenty
            case some
            case few
            case empty
            case unknown
            
            var description: String {
                switch self {
                case .plenty:
                    return "100개 이상"
                case .some:
                    return "30개 ~ 99개"
                case .few:
                    return "30개 미만"
                case .empty:
                    return "1개 이하"
                case .unknown:
                    return "정보 없음"
                }
            }
            
            var tintColor: UIColor {
                switch self {
                case .plenty:
                    return .systemGreen
                case .some:
                    return .systemYellow
                case .few:
                    return .systemRed
                case .empty:
                    return .systemGray
                case .unknown:
                    return .systemBackground
                }
            }
            
            var priority: Int {
                switch self {
                case .plenty:
                    return 1
                case .some:
                    return 2
                case .few:
                    return 3
                case .empty:
                    return 4
                case .unknown:
                    return 5
                }
            }
            
            var isOnSale: Bool {
                switch self {
                case .plenty,
                     .some,
                     .few:
                    return true
                case .empty,
                     .unknown:
                    return false
                }
            }
        }
    }
}
