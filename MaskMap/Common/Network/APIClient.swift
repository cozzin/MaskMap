//
//  Promise+Moya.swift
//  MaskMap
//
//  Created by SeongHo.Hong on 2020/03/11.
//  Copyright © 2020 Cozzin. All rights reserved.
//

import Foundation
import PromiseKit
import Moya
import ObjectMapper

struct APIClient<Request, Response> where Request: TargetType, Response: BaseMappable {
    
    enum Exception: Error {
        case networkLayer(code: Int)
        case mapping
    }
    
    static func request(_ target: Request) -> Promise<Response>  {
        let provider = MoyaProvider<Request>()
        
        return Promise<Response> { resolver in
            provider.request(target, completion: { result in
                switch result {
                case let .success(moyaResponse):
                    guard moyaResponse.statusCode == 200 else {
                        resolver.reject(
                            Exception.networkLayer(code: moyaResponse.statusCode)
                        )
                        let json = try? JSONSerialization.jsonObject(with: moyaResponse.data, options: [])
                        print("error: \(json)")
                        return
                    }

                    do {
                        let json = try JSONSerialization.jsonObject(with: moyaResponse.data, options: [])
                        if let response = Mapper<Response>().map(JSONObject: json) {
                            resolver.fulfill(response)
                        } else {
                            resolver.reject(
                                Exception.mapping
                            )
                        }
                    } catch {
                        resolver.reject(error)
                    }
                case let .failure(error):
                    resolver.reject(error)
                }
            })
        }
    }
    
}
