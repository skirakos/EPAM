//
//  Task4ViewController.swift
//  AutolatoutPracticalTasks
//
//  Created by Kakhaberi Kiknadze on 20.03.25.
//

import UIKit

// Create a view with two subviews aligned vertically when in Compact width, Regular height mode.
// If the orientation changes to Compact-Compact, same 2 subviews should be aligned horizontally.
// Hou can use iPhone 16 simulator for testing.
final class Task4ViewController: UIViewController {
    let firstView = UIView()
    let secondView = UIView()
    private var activeConstraints: [NSLayoutConstraint] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        firstView.translatesAutoresizingMaskIntoConstraints = false
        secondView.translatesAutoresizingMaskIntoConstraints = false
        
        firstView.backgroundColor = .systemBlue
        secondView.backgroundColor = .systemRed
        
        view.addSubview(firstView)
        view.addSubview(secondView)
        
        applyLayout(for: traitCollection)
        registerForTraitChanges()
    }
    
    private func registerForTraitChanges() {
        let sizeTraits: [UITrait] = [UITraitVerticalSizeClass.self, UITraitHorizontalSizeClass.self]
        registerForTraitChanges(sizeTraits) { (self: Self, previousTraitCollection: UITraitCollection) in
            self.applyLayout(for: self.traitCollection)
            // TODO: -  Handle the trait change.
            
            //print("Trait collection changed:", self.traitCollection)
        }
    }
    private func applyLayout(for traits: UITraitCollection) {
        NSLayoutConstraint.deactivate(activeConstraints)
        
        if traits.horizontalSizeClass == .compact && traits.verticalSizeClass == .regular {
            // Vertical layout
            activeConstraints = [
                firstView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                firstView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                firstView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                firstView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
                
                secondView.topAnchor.constraint(equalTo: firstView.bottomAnchor, constant: 20),
                secondView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                secondView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                secondView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            ]
        } else {
            // Horizontal layout
            activeConstraints = [
                firstView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
                firstView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                firstView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45),
                firstView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor),
                
                secondView.topAnchor.constraint(equalTo: firstView.topAnchor),
                secondView.leadingAnchor.constraint(equalTo: firstView.trailingAnchor, constant: 20),
                secondView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                secondView.heightAnchor.constraint(equalTo: firstView.heightAnchor)
            ]
        }
        
        NSLayoutConstraint.activate(activeConstraints)
    }
    
}

#Preview {
    Task4ViewController()
}
