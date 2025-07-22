//
//  ViewController.swift
//  AppStateChanges
//
//  Created by Seda Kirakosyan on 14.07.25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appDidEnterBackground),
            name: UIApplication.didEnterBackgroundNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appWillEnterForeground),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
        
    }
    @objc func appDidEnterBackground() {
        print("App Entered Background")
    }
    @objc func appWillEnterForeground() {
        print("App Will Enter Foreground")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

