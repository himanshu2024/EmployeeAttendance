//
//  DeviceInfoHelper.swift
//  EmployeeAttendance
//
//  Created by Himanshu Chaurasiya on 17/01/20.
//  Copyright © 2020 HPC. All rights reserved.
//

import Foundation

protocol DeviceInfo {
    var deviceUniqueId : String{get}
}
extension DeviceInfo{
    var deviceUniqueId : String{
        return "3c968fd8-c11b-47ee-b8db-54a79c7fa414"
    }
    
}
