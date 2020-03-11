//
//  PostOffice.swift
//  MaskMap
//
//  Created by SeongHo.Hong on 2020/03/11.
//  Copyright © 2020 Cozzin. All rights reserved.
//

import Foundation

final class PostOffice {
    
    static func convertLongCityName(_ address: String) -> String {
        address
            .replacingOccurrences(of: "서울시", with: "서울특별시")
            .replacingOccurrences(of: "부산시", with: "부산광역시")
            .replacingOccurrences(of: "대구시", with: "대구광역시")
            .replacingOccurrences(of: "인천시", with: "인천광역시")
            .replacingOccurrences(of: "광주시", with: "광주광역시")
            .replacingOccurrences(of: "대전시", with: "대전광역시")
            .replacingOccurrences(of: "울산시", with: "울산광역시")
    }
    
}
