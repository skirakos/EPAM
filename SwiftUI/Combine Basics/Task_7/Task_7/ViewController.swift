//
//  ViewController.swift
//  Task_7
//
//  Created by Seda Kirakosyan on 07.08.25.
//

import UIKit
import Combine

class ViewController: UIViewController {
    private var button: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints  = false
        btn.setTitle("  Click me!  ", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 8
        return btn
    }()
    private var count = 0
    private let publisher = PassthroughSubject<Void, Never>()
    private var cancelable: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        cancelable  = publisher
            .sink { [weak self] _ in
                self?.count += 1
                print("Button pressed \(self?.count ?? 0) times")
            }
    }
    
    @objc func buttonTapped() {
        publisher.send()
        
    }
    
    func setupUI() {
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
        ])
    }

}

#Preview {
    ViewController()
}
