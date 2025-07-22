//
//  ViewController.swift
//  CustomNC
//
//  Created by Seda Kirakosyan on 14.07.25.
//

import UIKit

class ViewController: UIViewController {
    private let buttonVC: ButtonVC = .init()
    private let labelVC: LabelVC = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add ButtonVC
        addChild(buttonVC)
        buttonVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonVC.view)
        buttonVC.didMove(toParent: self)

        // Add LabelVC
        addChild(labelVC)
        labelVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelVC.view)
        labelVC.didMove(toParent: self)

        // Layout
        NSLayoutConstraint.activate([
            buttonVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            buttonVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            buttonVC.view.heightAnchor.constraint(equalToConstant: 30),

            labelVC.view.topAnchor.constraint(equalTo: buttonVC.view.bottomAnchor, constant: 16),
            labelVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            labelVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            labelVC.view.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}

class ButtonVC: UIViewController {
    
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Click me!", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .blue
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    @objc func buttonTapped() {
        NotificationCenter.default.post(name: NSNotification.Name("ButtonTapped"), object: nil)
    }
}

class LabelVC: UIViewController {
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Not tapped"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 16)
        ])
        
        NotificationCenter.default.addObserver(self, selector: #selector(buttonTapped), name: NSNotification.Name("ButtonTapped"), object: nil)
    }
    @objc func buttonTapped() {
        label.text = "Tapped!"
        print("tapped")
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

#Preview {
    ViewController()
}
