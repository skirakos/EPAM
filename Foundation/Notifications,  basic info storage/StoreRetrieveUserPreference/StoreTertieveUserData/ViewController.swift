//
//  ViewController.swift
//  StoreTertieveUserData
//
//  Created by Seda Kirakosyan on 21.07.25.
//

import UIKit

class ViewController: UIViewController {
    
    private let userDefaults: UserDefaults = UserDefaults.standard
    
    private let toggleSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
    }()
    
    private let stateLabel: UILabel = {
        let label = UILabel()
        label.text = "Light mode is on"
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(toggleSwitch)
        view.addSubview(stateLabel)
        
        toggleSwitch.isOn = userDefaults.bool(forKey: "Mode")
        toggleSwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            toggleSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toggleSwitch.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            stateLabel.topAnchor.constraint(equalTo: toggleSwitch.bottomAnchor, constant: 20),
            stateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        if userDefaults.bool(forKey: "Mode") == false {
            stateLabel.text = "Light mode is on"
            view.backgroundColor = .white
            stateLabel.textColor = .black
            
        } else {
            stateLabel.text = "Dark mode is on"
            view.backgroundColor = .black
            stateLabel.textColor = .white
        }
    }
    
    @objc private func switchChanged(_ sender: UISwitch) {
        if sender.isOn {
            userDefaults.set(true, forKey: "Mode")
            stateLabel.text = "Dark mode is on"
            view.backgroundColor = .black
            stateLabel.textColor = .white
        } else {
            stateLabel.text = "Light mode is on"
            userDefaults.set(false, forKey: "Mode")
            view.backgroundColor = .white
            stateLabel.textColor = .black
            
        }
    }
}

#Preview {
    ViewController()
}
