//
//  SyncProtocol.swift
//  EmployeeAttendance
//
//  Created by Himanshu Chaurasiya on 16/01/20.
//  Copyright © 2020 HPC. All rights reserved.
//

import Foundation

protocol SyncProtocol{
    func syncStart(syncParam : SyncParam, completion : @escaping(Bool,String)->Void)
    func cancelSync() -> Bool
}

protocol SyncProgressProtocol {
    func syncProgressStatus(message : String)
    func syncCompleted()
    func syncFailed()
}
