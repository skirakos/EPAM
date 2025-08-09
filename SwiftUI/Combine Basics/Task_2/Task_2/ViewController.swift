//
//  ViewController.swift
//  Task_2
//
//  Created by Seda Kirakosyan on 04.08.25.
//

import UIKit
import Combine

class ViewController: UIViewController {

    var cancellable: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let publisher = Future<String, Never> { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
                promise(.success("Hello, Combine!"))
            }
        }
        
        cancellable = publisher.sink { string in
            print(string)
        }
    }
}
