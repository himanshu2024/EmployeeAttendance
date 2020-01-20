//
//  FirstSyncHelper.swift
//  EmployeeAttendance
//
//  Created by Himanshu Chaurasiya on 17/01/20.
//  Copyright © 2020 HPC. All rights reserved.
//

import Foundation

enum SyncFailed {
    case NoInternet
    case DeviceNotRegistered
    case InvalidData
    case Other
}

protocol FirstSync : SyncProgressProtocol, DeviceInfo {
    func checkForSync(syncParam : SyncParam?)
    func progressUpdate(message : String)
    func onNextPage()
    func onError(dueTo : SyncFailed)
}

extension FirstSync{
    
    func syncProgressStatus(message: String) {
        progressUpdate(message: message)
    }
    
    func syncCompleted() {
        validateLocalData()
    }
    
    func syncFailed() {
        onError(dueTo: .Other)
    }
    
    func checkForSync(syncParam : SyncParam?) {
        progressUpdate(message: "Initialising application... please wait.")
        var param = syncParam
        //check for internet connection
        if true{
            if param == nil{
                //call api to get sync param
                //OR
                param = SyncParam(rowId: 0, syncDescription: "", url: "https://zsync-dwp2.donseed.com", dbFile: "zss_dwp2_01", scheme: [ "scheme_type": "default"], user: self.deviceUniqueId, password: "s1m310", sendAuth: false, isForceSync: true)
            }
            checkLocalData(syncParam: param)
        }
    }
    
    private func checkLocalData(syncParam : SyncParam?) {
        if DatabaseManager.shared.isDataAvailableInDB(){
            validateLocalData()
        }
        else{
            if let param = syncParam{
                firstSync(syncParam: param)
            }
            else{
                onError(dueTo: .InvalidData)
            }
        }
    }
    
    private func validateLocalData() {
        if let device = DeviceEntity.shared.firstDevice(){
            if device.isActive{
                onNextPage()
            }
            else{
                onError(dueTo: .InvalidData)
            }
        }
    }
    
    private func firstSync(syncParam : SyncParam) {
        let syncManager = SyncManager()
        syncManager.syncProgressUpdateDelegate = self
        syncManager.syncStart(syncParam: syncParam) {
            (isSuccess, message) in
            if isSuccess{
                self.onNextPage()
            }
            else{
                self.onError(dueTo: .Other)
            }
        }
    }
}
