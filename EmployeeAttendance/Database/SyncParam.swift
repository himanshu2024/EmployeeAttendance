//
//  SyncParam.swift
//  EmployeeAttendance
//
//  Created by Himanshu Chaurasiya on 14/01/20.
//  Copyright © 2020 HPC. All rights reserved.
//

import Foundation
struct SyncParam {
    var rowId : Int
    var syncDescription : String
    var url : String
    var dbFile : String
    var scheme : Dictionary<String,String>
    var user : String
    var password : String
    var sendAuth : Bool
    var isForceSync : Bool
}
