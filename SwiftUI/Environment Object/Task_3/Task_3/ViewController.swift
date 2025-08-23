//
//  ViewController.swift
//  Task_3
//
//  Created by Seda Kirakosyan on 23.08.25.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show SwiftUI Screen", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        button.addTarget(self, action: #selector(showSwiftUI), for: .touchUpInside)
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

    }
    @objc func showSwiftUI() {
        let swiftUIViewController = UIHostingController(rootView: SwiftUIView(dismiss: { [weak self] in
            self?.dismiss(animated: true)
        }))
        present(swiftUIViewController, animated: true)
    }

}

