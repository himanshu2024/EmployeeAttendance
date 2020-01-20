//
//  SyncManager.swift
//  EmployeeAttendance
//
//  Created by Himanshu Chaurasiya on 14/01/20.
//  Copyright © 2020 HPC. All rights reserved.
//

import Foundation
import UIKit

class SyncManager : SyncProtocol{
    var syncProgressUpdateDelegate: SyncProgressProtocol?
    
    let dbPath = (UIApplication.shared.delegate as! AppDelegate).getDBFilePath()
    var syncStage : Int?
    var cancelToken : Int32?
    
    
    func syncStart(syncParam: SyncParam, completion: @escaping (Bool, String) -> Void) {
        let dispatchQueue = DispatchQueue(label: "QueueIdentification", qos: .background)
        dispatchQueue.async{
            do{
                
                try ZumeroSync.sync(self.dbPath, cipherKey: nil, serverUrl: syncParam.url, remote: syncParam.dbFile, authScheme: syncParam.scheme, user: syncParam.user, password: syncParam.password, callback: {
                    (cancellationToken,  phase,  bytesSoFar,  bytesTotal,  object)
                    in
                    print(cancellationToken)
                    var syncProgressString : String = ""
                    switch phase{
                    case ZUMERO_PHASE_PREPARING:
                        syncProgressString = "Data Sync - Preparing"
                    case ZUMERO_PHASE_UPLOADING:
                        syncProgressString = "Data Sync - Uploading"
                    case ZUMERO_PHASE_WAITING_FOR_RESPONSE:
                        syncProgressString = "Data Sync - Waiting for response"
                    case ZUMERO_PHASE_DOWNLOADING:
                        let progress = (Float)(Double(bytesSoFar) / Double(bytesTotal))
                        let percentage = (Int) (progress * 100);
                        syncProgressString = "Data Sync - \(percentage) % Downloaded"
                    case ZUMERO_PHASE_APPLYING:
                        syncProgressString = "Data Sync - Applying Change"
                    default:
                        syncProgressString = "Data Sync - In progress"
                    }
                    self.syncProgressUpdateDelegate?.syncProgressStatus(message: syncProgressString)
                }, dataPointer: nil, options: nil, syncId: nil)
                
                //try ZumeroSync.sync(self.dbPath, cipherKey: nil, serverUrl: syncParam.url, remote: syncParam.dbFile, authScheme: syncParam.scheme, user: syncParam.user, password: syncParam.password)
                completion(true,"")
                self.syncProgressUpdateDelegate?.syncCompleted()
            }
            catch {
                print(error.localizedDescription)
                completion(false,error.localizedDescription)
                self.syncProgressUpdateDelegate?.syncFailed()
            }
        }
    }
    
    func cancelSync() -> Bool {
        
        guard let stage = syncStage, let token = cancelToken else {
            return false
        }
        if stage == 0 || stage == 2{
            return false
        }
        ZumeroSync.cancel(token)
        return true
    }
    
    
    //    var syncProgressCallback = {
    //        (cancellationToken,  phase,  bytesSoFar,  bytesTotal,  object)
    //        in
    //        print(cancellationToken)
    //    }
}
//@objc extension SyncManager : ZumeroProgressCallback{
//    @objc override func ZumeroProgressCallback(a:Int,b:Int,c:Int,d:String) {
//
//    }
//}
