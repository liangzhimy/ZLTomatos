//
//  ViewController.swift
//  ZLTomatos
//
//  Created by zhaoliang on 2017/6/30.
//  Copyright © 2017年 zhaoliang. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, ZLTimeManagerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

        ZLTimeManager.sharedInstance.delegate = self
        ZLTimeManager.sharedInstance.start()
        
        
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func didTimeOut(type: ZLTimeType) -> Void {
        print("timeOut")
    }
    
    func didTimeTrigger(type: ZLTimeType, remainderTimeInterval: TimeInterval?) {
        print("remainderTimer \(remainderTimeInterval!)")
    }

}

