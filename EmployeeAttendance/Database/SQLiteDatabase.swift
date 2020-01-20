//
//  SQLiteDatabase.swift
//  EmployeeAttendance
//
//  Created by Himanshu Chaurasiya on 14/01/20.
//  Copyright © 2020 HPC. All rights reserved.
//
import SQLite

class SQLiteDatabase {
    static let shared = SQLiteDatabase()
    public let connection: Connection?
    let dbPath = (UIApplication.shared.delegate as! AppDelegate).getDBFilePath()
    private init() {
        do {
            connection = try Connection(dbPath)
            print("Sqlite Connected")
        } catch {
            connection = nil
            let nserror = error as NSError
            print("Cannot connect to Database. Error is: \(nserror), \(nserror.userInfo)")
        }
    }
}
