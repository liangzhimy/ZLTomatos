//
//  ZLTimeRecord.swift
//  ZLTomatos
//
//  Created by zhaoliang on 2017/6/30.
//  Copyright © 2017年 zhaoliang. All rights reserved.
//

import Cocoa

class ZLTimeRecord: NSObject {
    private dynamic var _beginDate: Date? = Date()
    private dynamic var _spendTotalTimeInterval: TimeInterval = 0
    private var _endDate: Date? = nil

    dynamic var recordId: Int = 0
    var timeType: ZLTimeType = ZLTimeType.None
    var needTimeInterval: TimeInterval = 0
    
    var remainderTimerInterval : TimeInterval {
        return self.needTimeInterval - self.spendTotalTimeInterval;
    }
    
    var spendTotalTimeInterval : TimeInterval {
            if (self._beginDate != nil) {
                return Date().timeIntervalSince(self._beginDate!) + _spendTotalTimeInterval;
            } else {
                return _spendTotalTimeInterval;
            }
    }
    
    init(recordId:Int, timeType:ZLTimeType) {
        self.recordId = recordId
        self.timeType = timeType
        let setting = ZLTimeSetting.loadFromeData()
        self.needTimeInterval = setting.timeIntervalWithType(type:timeType)
    }
    
    func begin() -> Void {
        _beginDate = Date()
    }
    
    func pause() -> Void {
        if (self._beginDate != nil) {
            self._spendTotalTimeInterval += Date().timeIntervalSince(self._beginDate!)
            self._beginDate = nil;
        }
    }
    
    func end() -> Void {
        self._beginDate = nil;
        self._endDate = Date()
        //TODO: save date
    }
    
    func cancel() -> Void {
        //TODO: delete date
    }
    
    static func generatorId() -> Int {
        return 0
    }
}
