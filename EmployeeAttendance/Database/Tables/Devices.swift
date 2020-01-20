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

    private let dbConnection = SQLiteDatabase.shared.connection

    private(set) var tblDevices = Table("tblDevices")
    
    private(set) var deviceId = Expression<Int>("device_id")
    private(set) var clientId = Expression<Int>("client_id")
    private(set) var deviceUniqueId = Expression<String>("device_unique_id")
    private(set) var isActive = Expression<Bool>("is_active")
    private(set) var locationId = Expression<Int>("location_id")
    private(set) var zoneId = Expression<Int?>("zone_id")
    private(set) var mobileNumber = Expression<String?>("mobile_number")
    private(set) var pin = Expression<String?>("pin")
    private(set) var os = Expression<String?>("os")
    private(set) var configSettings = Expression<String?>("config_settings")
    private(set) var softwareVersion = Expression<String?>("software_version")
    private(set) var syncFreq = Expression<Int?>("sync_freq")
    private(set) var deviceModelId = Expression<Int?>("device_model_id")
}

extension DeviceEntity{
    func allDevices() -> Array<Devices> {
        var array  = Array<Devices>()
        do {
            if let rows = try dbConnection?.prepare(self.tblDevices){
                for row in rows{
                    array.append(getDevice(from: row))
                }
            }
        } catch {
            let nserror = error as NSError
            print("Cannot query(list) all tblDevices. Error is: \(nserror), \(nserror.userInfo)")
            
        }
        return array
    }
    
    func firstDevice() -> Devices? {
        var device : Devices?
        do {
            if let row = try dbConnection?.pluck(self.tblDevices){
                device = getDevice(from: row)
            }
        } catch {
            let nserror = error as NSError
            print("Cannot query(list) all tblDevices. Error is: \(nserror), \(nserror.userInfo)")
        }
        return device
    }

    func getDevice(from row : Row) -> Devices {
        return Devices(deviceId: row[deviceId], clientId: row[clientId], deviceUniqueId: row[deviceUniqueId], isActive: row[isActive], locationId: row[locationId], zoneId: row[zoneId], mobileNumber: row[mobileNumber], pin: row[pin], os: row[os], configSettings: row[configSettings], softwareVersion: row[softwareVersion], syncFreq: row[syncFreq], deviceModelId: row[deviceModelId])
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
