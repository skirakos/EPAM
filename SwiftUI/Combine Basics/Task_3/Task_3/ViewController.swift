//
//  ViewController.swift
//  Task_3
//
//  Created by Seda Kirakosyan on 06.08.25.
//

import UIKit
import Combine

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let namePublisher = CurrentValueSubject<String, Never>("john")
        let surnamePublisher = CurrentValueSubject<String, Never>("smith")
        
        let capitalizedNamePublisher = namePublisher.map { $0.uppercased() }
        let surnamePublisherTransformed = surnamePublisher.map { $0.lowercased() }
        
        let subscription = capitalizedNamePublisher
            .combineLatest(surnamePublisherTransformed)
            .sink { name, surname in
                        print("\(name) \(surname)")
                    }
        
        subscription.cancel()
    }


}

