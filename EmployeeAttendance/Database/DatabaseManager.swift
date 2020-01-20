//
//  DatabaseManager.swift
//  EmployeeAttendance
//
//  Created by Himanshu Chaurasiya on 18/01/20.
//  Copyright © 2020 HPC. All rights reserved.
//

import Foundation
import SQLite

class DatabaseManager {
    static let shared = DatabaseManager()
    private let dbConnection = SQLiteDatabase.shared.connection
    
    //MARK:DB Table Variable
    private let device = DeviceEntity.shared
    private let location = LocationEntity.shared
    
    //MARK:tblDevices Query func
    
    
    func isDataAvailableInDB() -> Bool{
        var hasData = false
        do {
            let query = device.tblDevices.join(location.tblLocations, on: location.tblLocations[location.locationId] == device.tblDevices[device.locationId])
            if let row = try dbConnection?.pluck(query.select(device.deviceId, device.tblDevices[device.locationId], device.tblDevices[device.clientId])){
                hasData = true
            }
        } catch {
            let nserror = error as NSError
            print("Cannot query(list) all tblDevices. Error is: \(nserror), \(nserror.userInfo)")
        }
        return hasData
    }
}

extension DatabaseManager{
    
    
}
