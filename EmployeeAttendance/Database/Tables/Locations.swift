//
//  Locations.swift
//  EmployeeAttendance
//
//  Created by Himanshu Chaurasiya on 18/01/20.
//  Copyright © 2020 HPC. All rights reserved.
//

import Foundation
import SQLite

class LocationEntity {
    static let shared = LocationEntity()

    private let dbConnection = SQLiteDatabase.shared.connection

    private(set) var tblLocations = Table("tblLocations")
    
    private(set) var locationId = Expression<Int>("location_id")
    private(set) var locationName = Expression<String?>("location_name")
    private(set) var autoSignoutHours = Expression<Int?>("auto_signout_hours")
    private(set) var hsText = Expression<String?>("hs_text")
    private(set) var useBREEAM = Expression<Int?>("use_BREEAM") 
}

struct Locations {
    var clientId : Int
    var locationId : Int
    var zoneId : Int?
    var locationName : String?
    var autoSignout_Hours : Int?
    var hsText : String?
    var useBREEAM : Int?
}

