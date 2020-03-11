//
//  DateFormatTransform.swift
//  MaskMap
//
//  Created by SeongHo.Hong on 2020/03/11.
//  Copyright © 2020 Cozzin. All rights reserved.
//

import Foundation
import ObjectMapper

public class DateFormatTransform: TransformType {
    
    public typealias Object = Date
    public typealias JSON = String
    
    private let dateFormater: DateFormatter
    
    init(dateFormat: String = "yyyy-MM-dd HH:mm:ss") {
        dateFormater = DateFormatter(withFormat: dateFormat, locale: "ko_KR")
    }
    
    public func transformFromJSON(_ value: Any?) -> Date? {
        (value as? String).flatMap { dateFormater.date(from: $0) }
    }
    
    public func transformToJSON(_ value: Date?) -> JSON? {
        value.flatMap { dateFormater.string(from: $0) }
    }
    
}
