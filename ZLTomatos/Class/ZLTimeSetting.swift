//
//  ZLTimeSetting.swift
//  ZLTomatos
//
//  Created by zhaoliang on 2017/6/30.
//  Copyright © 2017年 zhaoliang. All rights reserved.
//

import Cocoa

class ZLTimeSetting: NSObject {
    
    var workingDuration: TimeInterval = 1 * 60
    var restDuration: TimeInterval = 5 * 60
    var workingHotKey: String?
    var restHotKey: String?
    var workingSound: String?
    var restSound: String?
    var isLaunchAtFirst: Bool = false
    
    func timeIntervalWithType(type:ZLTimeType) -> TimeInterval {
        switch type {
        case ZLTimeType.Working:
            return workingDuration
        case ZLTimeType.Rest:
            return restDuration
        default:
            return 0
        }
    }
    
    static func save() -> Void {
        
    }
    
    static func loadFromeData() -> ZLTimeSetting {
        let setting = ZLTimeSetting()
        return setting
    }
}
