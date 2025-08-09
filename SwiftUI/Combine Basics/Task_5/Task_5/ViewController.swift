//
//  ViewController.swift
//  Task_5
//
//  Created by Seda Kirakosyan on 06.08.25.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    private let publisher = CurrentValueSubject<String, Never>("")
    var cancelable: AnyCancellable?
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.tintColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)

        
        cancelable = publisher
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink { value in
                print(value)
            }
        
    }
    
    @objc func textChanged() {
        publisher.send(textField.text ?? "")
    }
    func setupUI() {
        view.addSubview(textField)
         
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
    }
}

//#Preview {
//    ViewController()
//}
