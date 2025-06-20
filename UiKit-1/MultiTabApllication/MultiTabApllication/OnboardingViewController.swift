//
//  OnboardingViewController.swift
//  MultiTabApllication
//
//  Created by Seda Kirakosyan on 16.06.25.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    let startButton = UIButton(type: .system)
    let titleLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupTitleLabel()
        setupStartButton()
        layoutViews()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateForRestart), name: NSNotification.Name("OnboardingConfirmed"), object: nil)

    }
    @objc private func updateForRestart() {
        startButton.setTitle("Restart", for: .normal)
        startButton.backgroundColor = .systemGreen
    }
    private func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Welcome to the App!"
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
    }
    
    private func setupStartButton() {
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.setTitle("Start", for: .normal)
        startButton.backgroundColor = .systemBlue
        startButton.setTitleColor(.white, for: .normal)
        startButton.layer.cornerRadius = 10
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        view.addSubview(startButton)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            startButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.widthAnchor.constraint(equalToConstant: 150),
            startButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc func startButtonTapped() {
        let personalInfoVC = PersonalInfoViewController()
        navigationController?.pushViewController(personalInfoVC, animated: false)
    }
}
class PreferencesViewController: UIViewController {
    var userName: String = ""
    var userPhone: String = ""
    private let preferenceLabel = UILabel()
    private var selectedPreference: String = "" {
        didSet {
            preferenceLabel.text = "Notification Preference: \(selectedPreference)"
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Preferences"
        //view.backgroundColor = .systemMint
        setupSelectBtn()
        setupSelectLabel()
        setupActionSheet()
    }
    func setupSelectLabel() {
        preferenceLabel.text = "No preference selected"
        preferenceLabel.textAlignment = .center
        preferenceLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(preferenceLabel)
        
        NSLayoutConstraint.activate([
            preferenceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            preferenceLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 20)
        ])
    }
    func setupSelectBtn() {
        let selectBtn = UIButton(type: .system)
        selectBtn.setTitle("Select Notification Preference", for: .normal)
        selectBtn.backgroundColor = .systemBlue
        selectBtn.layer.cornerRadius = 10
        selectBtn.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        selectBtn.titleLabel?.textColor = .white
        selectBtn.setTitleColor(.white, for: .normal)
        selectBtn.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(selectBtn)
        
        
        NSLayoutConstraint.activate([
            selectBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selectBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            selectBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            selectBtn.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        let select_action = UIAction { [weak self] _ in
            self?.setupActionSheet()
        }
        selectBtn.addAction(select_action, for: .touchUpInside)
    }
    func setupActionSheet() {
        let actionSheet = UIAlertController(title: "Select Notification Preference", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Email", style: .default, handler: { _ in
            self.selectedPreference = "Email Notifications"
            self.confirm()
        }))
        actionSheet.addAction(UIAlertAction(title: "SMS", style: .default, handler: { _ in
            self.selectedPreference = "SMS Notifications"
            self.confirm()
        }))
        actionSheet.addAction(UIAlertAction(title: "Push", style: .default, handler: { _ in
            self.selectedPreference = "Push Notifications"
            self.confirm()
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true)
    }
    func confirm() {
        let confirmDetailsVC = ConfirmDetailsViewController()
        confirmDetailsVC.name = self.userName
        confirmDetailsVC.phone = self.userPhone
        confirmDetailsVC.notifPreference = self.selectedPreference
        navigationController?.pushViewController(confirmDetailsVC, animated: false)
    }
}

class ConfirmDetailsViewController: UIViewController {
    var name: String = ""
    var phone: String = ""
    var notifPreference: String = ""
    
    private let nameLabel = UILabel()
    private let phoneLabel = UILabel()
    private let preferenceLabel = UILabel()

    private let editPersonalInfoButton = UIButton(type: .system)
    private let editPreferencesButton = UIButton(type: .system)
    private let startOverButton = UIButton(type: .system)
    private let confirmButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Confirm Details"
        
        navigationItem.hidesBackButton = true
        
        setupLabels()
        setupButtons()
        layoutUI()
    }
    private func setupLabels() {
        nameLabel.text = "Name: \(name)"
        phoneLabel.text = "Phone Number: \(phone)"
        preferenceLabel.text = "Notification Preference: \(notifPreference)"

        [nameLabel, phoneLabel, preferenceLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.font = UIFont.systemFont(ofSize: 18)
            view.addSubview($0)
        }
    }
    private func setupButtons() {
        configureButton(editPersonalInfoButton, title: "Edit personal info", action: #selector(editPersonalInfo))
        configureButton(editPreferencesButton, title: "Edit preferences", action: #selector(editPreferences))
        configureButton(startOverButton, title: "Start over", action: #selector(startOver))
        configureButton(confirmButton, title: "Confirm", action: #selector(confirmOnboarding))
    }
    private func configureButton(_ button: UIButton, title: String, action: Selector) {
        button.setTitle(title, for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: action, for: .touchUpInside)
        view.addSubview(button)
    }
    private func layoutUI() {
       NSLayoutConstraint.activate([
           nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
           nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

           phoneLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15),
           phoneLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

           preferenceLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 15),
           preferenceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

           editPersonalInfoButton.topAnchor.constraint(equalTo: preferenceLabel.bottomAnchor, constant: 40),
           editPersonalInfoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           editPersonalInfoButton.widthAnchor.constraint(equalToConstant: 200),
           editPersonalInfoButton.heightAnchor.constraint(equalToConstant: 44),

           editPreferencesButton.topAnchor.constraint(equalTo: editPersonalInfoButton.bottomAnchor, constant: 12),
           editPreferencesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           editPreferencesButton.widthAnchor.constraint(equalToConstant: 200),
           editPreferencesButton.heightAnchor.constraint(equalToConstant: 44),

           startOverButton.topAnchor.constraint(equalTo: editPreferencesButton.bottomAnchor, constant: 12),
           startOverButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           startOverButton.widthAnchor.constraint(equalToConstant: 200),
           startOverButton.heightAnchor.constraint(equalToConstant: 44),

           confirmButton.topAnchor.constraint(equalTo: startOverButton.bottomAnchor, constant: 20),
           confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           confirmButton.widthAnchor.constraint(equalToConstant: 200),
           confirmButton.heightAnchor.constraint(equalToConstant: 44),
       ])
   }
    @objc private func editPersonalInfo() {
        if let personalInfoVC = navigationController?.viewControllers.first(where: { $0 is PersonalInfoViewController }) {
            navigationController?.popToViewController(personalInfoVC, animated: true)
        }
    }

    @objc private func editPreferences() {
        if let preferencesVC = navigationController?.viewControllers.first(where: { $0 is PreferencesViewController }) {
            navigationController?.popToViewController(preferencesVC, animated: true)
        }
    }

    @objc private func startOver() {
        NotificationCenter.default.post(name: .didReturnFromConfirmDetails, object: nil)
        navigationController?.popViewController(animated: true)
    }


    @objc private func confirmOnboarding() {
        let alert = UIAlertController(title: "Success", message: "You have successfully passed the onboarding.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.navigationController?.popToRootViewController(animated: true)
            NotificationCenter.default.post(name: NSNotification.Name("OnboardingConfirmed"), object: nil)
        })
        present(alert, animated: true, completion: nil)
        
    }
}
#Preview {
    TabViewController()
    //ConfirmDetailsViewController()
}
