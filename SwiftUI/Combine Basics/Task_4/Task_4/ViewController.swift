//
//  ViewController.swift
//  Task_4
//
//  Created by Seda Kirakosyan on 06.08.25.
//

import UIKit
import Combine

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let intPublisher = PassthroughSubject<Int, Never>()
        
        let subscriber = intPublisher
            .filter { $0 % 2 == 0 }
            .sink(receiveValue: { print($0) })
        
        intPublisher.send(1)
        intPublisher.send(2)
        intPublisher.send(3)
        intPublisher.send(4)
        intPublisher.send(5)
        
        subscriber.cancel()
    }

}


