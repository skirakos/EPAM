//
//  LoginViewController.swift
//  SimpleLoginSystem
//
//  Created by Seda Kirakosyan on 21.07.25.
//

import UIKit


class LoginViewController: UIViewController {
    
//    private let userDefaults = UserDefaults.standard
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        label.text = "Welcome, \(UserDefaults.standard.string(forKey: "email") ?? "Unknown")"

        view.addSubview(label)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 32),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)

    }
    
    @objc func handleLogout() {
        userDefaults.removeObject(forKey: "email")
        userDefaults.set(false, forKey: "isLoggedIn")
        
        let mainVC = ViewController()
        mainVC.modalPresentationStyle = .fullScreen
        present(mainVC, animated: true)
    }
    
}

#Preview {
    LoginViewController()
}
