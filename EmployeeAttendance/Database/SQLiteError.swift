//
//  SQLiteError.swift
//  EmployeeAttendance
//
//  Created by Himanshu Chaurasiya on 14/01/20.
//  Copyright © 2020 HPC. All rights reserved.
//

import Foundation
enum SQLiteError: Error {
  case OpenDatabase(message: String)
  case Prepare(message: String)
  case Step(message: String)
  case Bind(message: String)
}
