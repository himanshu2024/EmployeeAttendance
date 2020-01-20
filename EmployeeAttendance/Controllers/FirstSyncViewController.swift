//
//  ViewController.swift
//  EmployeeAttendance
//
//  Created by Himanshu Chaurasiya on 08/01/20.
//  Copyright © 2020 HPC. All rights reserved.
//

import UIKit
import CoreData

class FirstSyncViewController: UIViewController {
    
    @IBOutlet weak var syncMessageLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    var vm : FirstSyncViewModel?
    
    //var array = [Employee]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let syncManager = SyncManager()
        syncManager.syncProgressUpdateDelegate = self
        vm = FirstSyncViewModel(syncManager: syncManager)

        var dm = DatabaseManager()
        //dm.getDevices()
        
        var x = DeviceEntity.shared.queryAll()
        
//        vm?.startSync { [unowned self]
//            (isSuccess, message) in
//            DispatchQueue.main.async {
//            self.loadingIndicator.isHidden = true
//            }
//        }
    }
    
    
//    /Library/Developer/CoreSimulator/Devices/2671AF09-0F29-4F08-B5B3-40FAEA95FAE1/data/Containers/Data/Application/79031FFD-1580-49F2-B06E-6CC82F521B9D/Documents/
}

extension FirstSyncViewController : SyncProgressProtocol{
    func syncProgressStatus(message: String) {
        DispatchQueue.main.async {
            self.syncMessageLabel.text = message
        }
        
    }
    
    func syncCompleted() {
        DispatchQueue.main.async {
        self.syncMessageLabel.text = "Sync completed successfully"
        }
    }
    
    func syncFailed() {
        DispatchQueue.main.async {
        self.syncMessageLabel.text = "Error"
        }
    }
    
    
}

