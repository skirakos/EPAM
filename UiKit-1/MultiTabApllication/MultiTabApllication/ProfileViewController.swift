//
//  ProfileViewController.swift
//  MultiTabApllication
//
//  Created by Seda Kirakosyan on 18.06.25.
//

import UIKit

class ProfileViewController: UIViewController {
    private let nameLabel = UILabel()
    private let editProfileButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Profile"
        
        setupNavBar()
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ProfileViewController - viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ProfileViewController - viewDidAppear")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("ProfileViewController - viewWillLayoutSubviews")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("ProfileViewController - viewDidLayoutSubviews")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("ProfileViewController - viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("ProfileViewController - viewDidDisappear")
    }
    func setupUI() {
        view.addSubview(nameLabel)
        view.addSubview(editProfileButton)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "Default"
        
        editProfileButton.setTitle("Edit Profile", for: .normal)
        editProfileButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        editProfileButton.translatesAutoresizingMaskIntoConstraints = false
        editProfileButton.addTarget(self, action: #selector(editProfileTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            
            editProfileButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30),
            editProfileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    private func setupNavBar() {
        let renameButton = UIBarButtonItem(
            image: UIImage(systemName: "pencil.slash"),
            style: .plain,
            target: self,
            action: #selector(promptForNewName)
        )

        let anonymousButton = UIBarButtonItem(
            image: UIImage(systemName: "person.crop.circle.fill"),
            style: .plain,
            target: self,
            action: #selector(setAnonymousName)
        )

        navigationItem.rightBarButtonItems = [anonymousButton, renameButton]
    }
    @objc private func editProfileTapped() {
        let editVC = EditProfileViewController()
        navigationController?.pushViewController(editVC, animated: true)
    }
    @objc private func promptForNewName() {
       let alert = UIAlertController(title: "Change Name", message: "Enter your new name:", preferredStyle: .alert)
       alert.addTextField()

       let confirm = UIAlertAction(title: "OK", style: .default) { _ in
           let input = alert.textFields?.first?.text?.trimmingCharacters(in: .whitespacesAndNewlines)
           if let newName = input, !newName.isEmpty {
               self.nameLabel.text = newName
           } else {
               self.nameLabel.text = "Default"
           }
       }

       alert.addAction(confirm)
       alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
       present(alert, animated: true)
   }

   @objc private func setAnonymousName() {
       nameLabel.text = "Anonymous"
   }
}

class EditProfileViewController: UIViewController {

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "You're in EditProfileViewController"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("EditProfile - viewDidLoad")

        title = "Edit profile"
        view.backgroundColor = .systemGray6

        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("EditProfile - viewWillAppear")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("EditProfile - viewDidAppear")
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("EditProfile - viewWillLayoutSubviews")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("EditProfile - viewDidLayoutSubviews")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("EditProfile - viewWillDisappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("EditProfile - viewDidDisappear")
    }

    private func setupUI() {
        view.addSubview(infoLabel)

        NSLayoutConstraint.activate([
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

#Preview {
//    ProfileViewController()
    TabViewController()
}
