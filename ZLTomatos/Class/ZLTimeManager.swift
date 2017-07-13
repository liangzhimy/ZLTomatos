//
//  ZLTimeManager.swift
//  ZLTomatos
//
//  Created by zhaoliang on 2017/6/30.
//  Copyright © 2017年 zhaoliang. All rights reserved.
//

import Cocoa

protocol ZLTimeManagerDelegate: class {
    
    func didTimeOut(type: ZLTimeType) -> Void
    func didTimeTrigger(type: ZLTimeType, remainderTimeInterval: TimeInterval?)
    
}

class ZLTimeManager: NSObject {
    static let sharedInstance = ZLTimeManager()
    weak var delegate: ZLTimeManagerDelegate?
    private var _timeRecording: ZLTimeRecord?
    var status: ZLStatusType = ZLStatusType.None
    var timer: Timer? = nil
    
    var timeRecording : ZLTimeRecord? {
        return _timeRecording;
    }
    
    var type: ZLTimeType {
        get {
            if (timeRecording != nil) {
                return _timeRecording!.timeType
            }
            return ZLTimeType.None
        }
        set(newType) {
            if (newType == ZLTimeType.None) {
                _timeRecording = nil;
                return;
            }
            if (timeRecording?.timeType != newType || timeRecording == nil) {
                _timeRecording = ZLTimeRecord(recordId:ZLTimeRecord.generatorId(), timeType:newType)
                _timeRecording?.timeType = newType
            }
        }
    }
    
    override private init() {
        
    }
    
    func process() -> Float {
        return 0
    }
    
    func remainingTime() -> TimeInterval {
        return 0
    }
    
    func start() -> Void {
        if (self.status == ZLStatusType.Runing || self.status == ZLStatusType.Pause) {
            return
        }
        
        if (self.timer != nil) {
            self.timer?.invalidate()
            self.timer = nil
        }
        
        if (self.type == ZLTimeType.None) {
            self.type = ZLTimeType.Working;
        }
        
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ZLTimeManager.trigger), userInfo: nil, repeats: true)
        self.timeRecording?.begin()
        self.status = ZLStatusType.Runing;
    }
    
    func trigger() -> Void {
        if (self.timeRecording == nil) {
            assert(false)
            return
        }
        
        let remainderTimerInterval = self.timeRecording?.remainderTimerInterval
        self.delegate?.didTimeTrigger(type: self.type, remainderTimeInterval: remainderTimerInterval)
        
        if ((Int)(remainderTimerInterval!) <= 0) {
            self.timeRecording!.end()
            self.delegate?.didTimeOut(type: self.type)
            self.timer?.invalidate()
            self.timer = nil
            if (self.type == ZLTimeType.Working) {
                self.type = ZLTimeType.Rest
            } else if (self.type == ZLTimeType.Rest) {
                self.type = ZLTimeType.Working
            }
        }
    }
    
    func resume() -> Void {
        if (self.status != ZLStatusType.Pause) {
            return;
        }
        
        self.timer?.fireDate = Date()
        self.timeRecording!.begin()
        self.status = ZLStatusType.Runing
    }
    
    func pause() -> Void {
        if (self.status != ZLStatusType.Runing) {
            return;
        }
        
        self.timer?.fireDate = Date.distantFuture
        self.timeRecording!.pause()
        self.status = ZLStatusType.Pause
    }
    
    func cancel() -> Void {
        self.status = ZLStatusType.None
        self.timer?.invalidate()
        self.timer = nil
        self.type = ZLTimeType.None
    }
    
    func totalOfToday() -> ZLTimeTotalOfDay? {
        return nil
    }
    
}
