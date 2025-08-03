//
//  ViewController.swift
//  Task_1
//
//  Created by Seda Kirakosyan on 03.08.25.
//

import UIKit
import Combine

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let publisher = Just("Hello, Combine!")
        
        let cancelable = publisher.sink { string in
            print(string)
        }
        cancelable.cancel()
    }


}

