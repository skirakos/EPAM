//
//  SettingsViewController.swift
//  MultiTabApllication
//
//  Created by Seda Kirakosyan on 18.06.25.
//

import UIKit

class SettingsViewController: UIViewController {
    private var label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Settings"
        
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        label.text = "Navigation is easy!"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        
    }
}
