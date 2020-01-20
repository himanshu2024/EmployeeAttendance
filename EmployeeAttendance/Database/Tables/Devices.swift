//
//  Devices.swift
//  EmployeeAttendance
//
//  Created by Himanshu Chaurasiya on 16/01/20.
//  Copyright © 2020 HPC. All rights reserved.
//

import Foundation
import SQLite

class DeviceEntity {
    static let shared = DeviceEntity()
    
    private let tblDevices = Table("tblDevices")
    
    private let id = Expression<Int>("device_id")
    private let clientId = Expression<Int>("client_id")
    private let deviceUniqueId = Expression<String>("device_unique_id")
    private let isActive = Expression<Bool>("is_active")
    private let locationId = Expression<Int>("location_id")
    private let zoneId = Expression<Int?>("zone_id")
    private let mobileNumber = Expression<String?>("mobile_number")
    private let pin = Expression<String?>("pin")
    private let os = Expression<String?>("os")
    private let configSettings = Expression<String?>("config_settings")
    private let softwareVersion = Expression<String?>("software_version")
    private let syncFreq = Expression<Int?>("sync_freq")
    private let deviceModelId = Expression<Int?>("device_model_id")
    
    //How to query(find) all records in tblDepartment ?
    func queryAll() -> Array<Devices> {
        var array  = Array<Devices>()
        do {
            if let rows = try SQLiteDatabase.shared.connection?.prepare(self.tblDevices){
                for row in rows{
                    array.append(getDevice(from: row))
                }
            }
        } catch {
            let nserror = error as NSError
            print("Cannot query(list) all tblDepartment. Error is: \(nserror), \(nserror.userInfo)")
            
        }
        return array
    }
    
    func getDevice(from row : Row) -> Devices {
        return Devices(deviceId: row[self.id], clientId: row[self.clientId], deviceUniqueId: row[self.deviceUniqueId], isActive: row[self.isActive], locationId: row[self.locationId], zoneId: row[self.zoneId], mobileNumber: row[self.mobileNumber], pin: row[self.pin], os: row[self.os], configSettings: row[self.configSettings], softwareVersion: row[self.softwareVersion], syncFreq: row[self.syncFreq], deviceModelId: row[self.deviceModelId])
    }
    
}

struct Devices {
    var deviceId : Int
    var clientId : Int
    var deviceUniqueId : String
    var isActive : Bool
    var locationId : Int
    var zoneId : Int?
    var mobileNumber : String?
    var pin : String?
    var os : String?
    var configSettings : String?
    var softwareVersion : String?
    var syncFreq : Int?
    var deviceModelId : Int?
}
