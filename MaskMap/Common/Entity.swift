//
//  Entity.swift
//  MaskMap
//
//  Created by SeongHo.Hong on 2020/03/11.
//  Copyright © 2020 Cozzin. All rights reserved.
//

import Foundation

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
        }
        
        /// 재고 상태[100개 이상(녹색): 'plenty' / 30개 이상 100개미만(노랑색): 'some' / 2개 이상 30개 미만(빨강색): 'few' / 1개 이하(회색): 'empty']
        enum RemainStatus: String {
            case plenty
            case some
            case few
            case empty
            case unknown
        }
    }
}
