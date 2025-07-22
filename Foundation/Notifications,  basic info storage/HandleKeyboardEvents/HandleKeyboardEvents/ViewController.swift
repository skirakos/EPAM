//
//  ViewController.swift
//  HandleKeyboardEvents
//
//  Created by Seda Kirakosyan on 14.07.25.
//

import UIKit

class ViewController: UIViewController {
    private let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter text"
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(textField)

        bottomConstraint = textField.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 150)
        bottomConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardON), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardOFF), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)

    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc func keyboardON() {
        bottomConstraint.isActive = false
        
        NSLayoutConstraint.activate([
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    @objc func keyboardOFF() {
        NSLayoutConstraint.deactivate(view.constraints.filter { $0.firstItem === textField && $0.firstAttribute == .centerY })
        bottomConstraint.isActive = true

        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

#Preview {
    ViewController()
}
