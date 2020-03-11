//
//  StoreEntity.swift
//  MaskMap
//
//  Created by SeongHo.Hong on 2020/03/11.
//  Copyright © 2020 Cozzin. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper

extension Entity {
    enum Search { }
}

extension Entity.Search {
            
    enum API {
        
        /// https://app.swaggerhub.com/apis-docs/Promptech/public-mask-info/20200307-oas3#/v1
        enum Request: TargetType {
            /// 중심 좌표(위/경도)를 기준으로 반경(미터단위) 안에 존재하는 판매처 및 재고 상태 등의 판매 정보 제공
            case storesByGeo(latitude: Double, longitude: Double, rangeMeter: Int)
            ///주소를 기준으로 해당 구 또는 동내에 존재하는 판매처 및 재고 상태 등의 판매 정보 제공.
            /// 예- '서울특별시 강남구' or '서울특별시 강남구 논현동'
            /// ('서울특별시' 와 같이 '시'단위만 입력하는 것은 불가능합니다.)
            case storesByAddress(address: String)
            
            var baseURL: URL {
                Entity.API.baseURL
            }
            
            var path: String {
                switch self {
                case .storesByGeo:
                    return "/storesByGeo/json"
                case .storesByAddress:
                    return "/storesByAddr/json"
                }
            }
            
            var method: Moya.Method {
                switch self {
                case .storesByGeo,
                     .storesByAddress:
                    return .get
                }
            }
            
            var sampleData: Data {
                Data()
            }
            
            var task: Task {
                switch self {
                case let .storesByGeo(latitude, longitude, rangeMeter):
                    return .requestParameters(
                        parameters: ["lat": latitude, "lng": longitude, "m": rangeMeter],
                        encoding: URLEncoding.default
                    )
                case .storesByAddress(let address):
                    return .requestParameters(
                        parameters: ["address" : address],
                        encoding: URLEncoding.queryString
                    )
                }
            }
            
            var headers: [String: String]? {
                return ["Content-type": "application/json"]
            }
            
        }
        
        struct Response: ImmutableMappable {
            struct Store: ImmutableMappable {
                let code: String?
                let name: String
                let address: String
                let type: Entity.Store.StoreType
                let location: Entity.Map.Location
                let stockDate: Date?
                let remainStatus: Entity.Store.RemainStatus
                
                init(map: Map) throws {
                    code = try? map.value("code")
                    name = try map.value("name")
                    address = try map.value("addr")
                    type = try map.value("type", using: EnumTransform<Entity.Store.StoreType>())
                    location = Entity.Map.Location(
                        latitude: try map.value("lat"),
                        longitude: try map.value("lng")
                    )
                    stockDate = try? map.value("stock_at", using: DateFormatTransform())
                    remainStatus = (try? map.value("remain_stat", using: EnumTransform<Entity.Store.RemainStatus>())) ?? .unknown
                }
            }
            
            let count: Int
            let stores: [Store]
            
            init(map: Map) throws {
                count = (try? map.value("count")) ?? 0
                stores = (try? map.value("stores")) ?? []
            }
        }
        
    }
    
    struct ViewModel {
        struct Store {
            let name: String
            let address: String
            let type: Entity.Store.StoreType
            let location: Entity.Map.Location
            let stockDate: Date?
            let remainStatus: Entity.Store.RemainStatus
            
            var isOnSale: Bool {
                remainStatus.isOnSale
            }
            
            var priority: Int {
                remainStatus.priority
            }
        }
        
        let stores: [Store]
    }
}
