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
    //var vm : FirstSyncViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.checkForSync(syncParam : nil)
    }
    
}

extension FirstSyncViewController : FirstSync{
    func progressUpdate(message: String) {
        DispatchQueue.main.async {
            self.syncMessageLabel.text = message
        }
    }
    
    func onNextPage() {
        DispatchQueue.main.async {
            self.syncMessageLabel.text = "GO to Home"
        }
    }
    
    func onError(dueTo: SyncFailed) {
        DispatchQueue.main.async {
            self.syncMessageLabel.text = "Error"
        }
    }
}

