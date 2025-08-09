//
//  ViewController.swift
//  Task_6
//
//  Created by Seda Kirakosyan on 07.08.25.
//

import UIKit
import Combine

class ViewController: UIViewController {
    private let publisher = PassthroughSubject<Int, Never>()
    private var cancelable: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cancelable = publisher
            .flatMap { int in
                return Just(int * int)
            }
            .sink(receiveValue: { print($0) })
        
        publisher.send(3)
        publisher.send(5)
        
    }


}

