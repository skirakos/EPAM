//
//  ViewController.swift
//  SimpleLoginSystem
//
//  Created by Seda Kirakosyan on 21.07.25.
//

import UIKit

let userDefaults = UserDefaults.standard

class ViewController: UIViewController {
    
//    private let userDefaults = UserDefaults.standard
    
    private let label: UILabel = UILabel()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your email"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .center
        view.addSubview(label)
        
        view.addSubview(textField)
        view.addSubview(button)
        label.text = "Login Page"
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            
            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.75),
            
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16),
            button.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 1),
        ])
        
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    }
    
    @objc func handleLogin() {
        print("Login button tapped")
        guard let email = textField.text, !email.isEmpty else {
            print("Email is empty")
            return
        }
        
        userDefaults.set(email, forKey: "email")
        userDefaults.set(true, forKey: "isLoggedIn")
        
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true)
    }
}

#Preview {
    ViewController()
}
