//
//  TabViewController.swift
//  MultiTabApllication
//
//  Created by Seda Kirakosyan on 16.06.25.
//

import UIKit

extension Notification.Name {
    static let didReturnFromConfirmDetails = Notification.Name("didReturnFromConfirmDetails")
}

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Onboarding Navigation Controller
        let onboardingVC = OnboardingViewController()
        onboardingVC.title = "Onboarding"
        let onboardingNC = UINavigationController(rootViewController: onboardingVC)
        onboardingNC.tabBarItem = UITabBarItem(title: "Onboarding",
                                               image: UIImage(systemName: "1.circle"),
                                               selectedImage: UIImage(systemName: "1.circle.fill"))

        // Profile Navigation Controller
        let profileVC = ProfileViewController()
        profileVC.title = "Profile"
        let profileNC = UINavigationController(rootViewController: profileVC)
        profileNC.tabBarItem = UITabBarItem(title: "Profile",
                                            image: UIImage(systemName: "person"),
                                            selectedImage: UIImage(systemName: "person.fill"))

        // Settings (no nav controller)
        let settingsVC = SettingsViewController()
        settingsVC.tabBarItem = UITabBarItem(title: "Settings",
                                             image: UIImage(systemName: "gearshape"),
                                             selectedImage: UIImage(systemName: "gearshape.fill"))

        setViewControllers([onboardingNC, profileNC, settingsVC], animated: false)
        
        
        // Customize tab bar appearance
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .orange

        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .gray
        tabBar.standardAppearance = appearance
        
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance // !!modern ios 15+ need this
        }
    }
}

class PersonalInfoViewController: UIViewController {
    let nameField = UITextField()
    let PhoneField = UITextField()
    let confirmBtn = UIButton()
    var cameFromConfirmDetails = false
    
    
   
    @objc private func handleReturnFromConfirmDetails() {
        print("✅ Notification received: Returned from ConfirmDetailsVC")
        self.cameFromConfirmDetails = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .systemRed
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleReturnFromConfirmDetails),
            name: .didReturnFromConfirmDetails,
            object: nil
        )
        
        nameField.placeholder = "Name"
        nameField.translatesAutoresizingMaskIntoConstraints = false
        nameField.borderStyle = .roundedRect
        
        
        PhoneField.placeholder = "Phone Number"
        PhoneField.translatesAutoresizingMaskIntoConstraints = false
        PhoneField.borderStyle = .roundedRect
        
        
        confirmBtn.translatesAutoresizingMaskIntoConstraints = false
        confirmBtn.backgroundColor = .systemBlue
        confirmBtn.setTitle("Confirm", for: .normal)
        confirmBtn.layer.cornerRadius = 10 // optional, looks better
        
        nameField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        nameField.addTarget(self, action: #selector(validateFields), for: .editingDidEnd)

        PhoneField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        PhoneField.addTarget(self, action: #selector(validateFields), for: .editingDidEnd)
        validateFields()
        
        let confirm_action = UIAction { [weak self] _ in
            self?.user_alert()
            
        }
        confirmBtn.addAction(confirm_action, for: .touchUpInside)
        
        view.addSubview(confirmBtn)
        view.addSubview(nameField)
        view.addSubview(PhoneField)
        
        NSLayoutConstraint.activate([
            nameField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            nameField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            nameField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            
            PhoneField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            PhoneField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 10),
            PhoneField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            
            confirmBtn.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            confirmBtn.topAnchor.constraint(equalTo: PhoneField.bottomAnchor, constant: 16),
            confirmBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
        ])
        
    }
    @objc func validateFields() {
        if (nameField.text?.isEmpty ?? true) || (PhoneField.text?.count ?? 0) < 9 {
            confirmBtn.isEnabled = false
            confirmBtn.backgroundColor = .gray
        } else {
            confirmBtn.isEnabled = true
            confirmBtn.backgroundColor = .systemBlue
        }
    }
    
    
    func user_alert() {
        guard let name = nameField.text, let phone = PhoneField.text else { return }

        let message = """
        Please confirm your name and phone number.

        Name: \(name.isEmpty ? "Not provided" : name)
        Phone: \(phone.isEmpty ? "Not provided" : phone)
        """

        let alert = UIAlertController(title: "Confirmation", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Edit", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }

            

            if self.cameFromConfirmDetails {
                if let confirmDetailsVC = self.navigationController?.viewControllers.first(where: { $0 is ConfirmDetailsViewController }) {
                    self.navigationController?.popToViewController(confirmDetailsVC, animated: true)
                    print("sdvfer")
                } else {
                    print("ConfirmDetailsViewController not found in the navigation stack.")
                }
            } else {
                let preferencesVC = PreferencesViewController()
                preferencesVC.userName = name
                preferencesVC.userPhone = phone
                print("aaaa")
                self.navigationController?.pushViewController(preferencesVC, animated: true)
            }
        }))
        
        self.present(alert, animated: true)
    }
}

#Preview {
    TabViewController()
}
