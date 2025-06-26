//
//  ViewController.swift
//  ProfilePage
//
//  Created by Seda Kirakosyan on 23.06.25.
//

import UIKit

struct UserProfile {
    let profileImageName: String
    let name: String
    let bio: String
    let isFollowing: Bool
    let stats: Statistics
    var isTaggedSectionVisible: Bool
    let taggedPostsCount: Int
}

struct Statistics {
    let followers: Int
    let following: Int
    let posts: Int
}

class ViewController: UIViewController {
    let mainStackView = UIStackView()
    let profileStackView = UIStackView()
    let bioStackView = UIStackView()
    let statsStackView = UIStackView()
    let taggedPostsView = UIStackView()
    
    let user = UserProfile(
        profileImageName: "profile_photo",
        name: "Seda Kirakosyan",
        bio: "iOS Developer • Coffee Enthusiast ☕️ Swift Fanatic",
        isFollowing: false,
        stats: Statistics(followers: 1234, following: 321, posts: 56),
        isTaggedSectionVisible: false,
        taggedPostsCount: 12
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStackView()
        setupTaggedPostsSection()
    }
    
    func setupStackView() {
        mainStackView.axis = .vertical
        mainStackView.spacing = 20
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

        setupProfileStackView()
        setupStatsStackView()
        setupBioStackView()
        setupToggleStackView()
    }
    
    func setupProfileStackView() {
        let profileImageView = UIImageView(image: UIImage(named: user.profileImageName))
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 30
        
        
        let nameLabel = UILabel()
        nameLabel.text = user.name
        nameLabel.textColor = .black
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        nameLabel.numberOfLines = 0
        
        
        let labelContainer = UIStackView()
        labelContainer.axis = .vertical
        labelContainer.alignment = .leading
        labelContainer.spacing = 16
        labelContainer.translatesAutoresizingMaskIntoConstraints = false
        labelContainer.addArrangedSubview(nameLabel)
        
        let followbtn = UIButton()
        followbtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        if user.isFollowing {
            followbtn.setTitle("Unfollow", for: .normal)
        } else {
            followbtn.setTitle("Follow", for: .normal)
        }
        followbtn.setTitleColor(.white, for: .normal)
        followbtn.backgroundColor = .systemBlue
        followbtn.layer.cornerRadius = 5
        labelContainer.addArrangedSubview(followbtn)

        profileStackView.translatesAutoresizingMaskIntoConstraints = false
        profileStackView.axis = .horizontal
        profileStackView.spacing = 12
        profileStackView.alignment = .top
        
        profileStackView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.layer.cornerRadius = 60
        profileStackView.addArrangedSubview(profileImageView)
        profileStackView.addArrangedSubview(labelContainer)
        mainStackView.addArrangedSubview(profileStackView)
        
//        bioStackView.backgroundColor = .green
//        statsStackView.backgroundColor = .red
//        view.backgroundColor = .systemBlue
//        profileStackView.backgroundColor = .yellow
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 120),
            profileImageView.heightAnchor.constraint(equalToConstant: 120),
            
            profileStackView.topAnchor.constraint(equalTo: mainStackView.topAnchor),
            profileStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 1),

            labelContainer.topAnchor.constraint(equalTo: mainStackView.topAnchor, constant: 16),
            
            followbtn.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func setupStatsStackView() {
        statsStackView.axis = .horizontal
        statsStackView.distribution = .fillEqually
        statsStackView.alignment = .center
        statsStackView.spacing = 16
        statsStackView.translatesAutoresizingMaskIntoConstraints = false

        
        let stats = [
            ("\(user.stats.followers)", "Followers"),
            ("\(user.stats.following)", "Following"),
            ("\(user.stats.posts)", "Posts")
        ]
        
        for (number, label) in stats {
            let verticalStack = UIStackView()
            verticalStack.axis = .vertical
            verticalStack.alignment = .center
            verticalStack.spacing = 4

            let numberLabel = UILabel()
            numberLabel.text = number
            numberLabel.font = UIFont.boldSystemFont(ofSize: 18)
            numberLabel.textColor = .black

            let titleLabel = UILabel()
            titleLabel.text = label
            titleLabel.font = UIFont.systemFont(ofSize: 14)
            titleLabel.textColor = .darkGray

            verticalStack.addArrangedSubview(numberLabel)
            verticalStack.addArrangedSubview(titleLabel)
            statsStackView.addArrangedSubview(verticalStack)
        }
    }
    
    func setupBioStackView() {
        bioStackView.translatesAutoresizingMaskIntoConstraints = false
        bioStackView.axis = .horizontal

        let bioLabel = UILabel()
        bioLabel.text = user.bio
        bioLabel.textAlignment = .center
        bioLabel.translatesAutoresizingMaskIntoConstraints = false
        bioLabel.font = UIFont.systemFont(ofSize: 14)
        bioLabel.numberOfLines = 0
        bioLabel.lineBreakMode = .byWordWrapping
        bioStackView.addArrangedSubview(bioLabel)
        
        mainStackView.addArrangedSubview(bioStackView)
        mainStackView.addArrangedSubview(statsStackView)
        
        NSLayoutConstraint.activate([
            bioLabel.topAnchor.constraint(equalTo: bioStackView.topAnchor),
            bioLabel.leadingAnchor.constraint(equalTo: bioStackView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: bioStackView.trailingAnchor),
            bioLabel.bottomAnchor.constraint(equalTo: bioStackView.bottomAnchor)
        ])
    }
    
    func setupToggleStackView() {
        let toggleTaggedButton = UIButton(type: .system)
        toggleTaggedButton.setTitle("Toggle Tagged Posts", for: .normal)
        toggleTaggedButton.setTitleColor(.white, for: .normal)
        toggleTaggedButton.backgroundColor = .systemGreen
        toggleTaggedButton.layer.cornerRadius = 5
        toggleTaggedButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        toggleTaggedButton.addTarget(self, action: #selector(toggleTaggedPosts), for: .touchUpInside)

        mainStackView.addArrangedSubview(toggleTaggedButton)
    }
    
    @objc func toggleTaggedPosts() {
        if mainStackView.arrangedSubviews.contains(taggedPostsView) {
            UIView.animate(withDuration: 0.3, animations: {
                self.taggedPostsView.isHidden = true
                self.mainStackView.layoutIfNeeded()
            }, completion: { _ in
                self.mainStackView.removeArrangedSubview(self.taggedPostsView)
                self.taggedPostsView.removeFromSuperview()
            })
        } else {
            taggedPostsView.isHidden = true
            mainStackView.insertArrangedSubview(taggedPostsView, at: 3)
            UIView.animate(withDuration: 0.3) {
                self.taggedPostsView.isHidden = false
                self.mainStackView.layoutIfNeeded()
            }
        }
    }

    func setupTaggedPostsSection() {
        taggedPostsView.axis = .horizontal
        taggedPostsView.alignment = .center
        taggedPostsView.spacing = 8
        taggedPostsView.translatesAutoresizingMaskIntoConstraints = false
        
        let icon = UIImageView(image: UIImage(systemName: "tag"))
        icon.tintColor = .white
        icon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        let label = UILabel()
        label.text = "Tagged Posts: \(user.taggedPostsCount)"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        
        taggedPostsView.addArrangedSubview(icon)
        taggedPostsView.addArrangedSubview(label)
        taggedPostsView.backgroundColor = .systemPurple
        taggedPostsView.isLayoutMarginsRelativeArrangement = true
        taggedPostsView.layoutMargins = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        taggedPostsView.layer.cornerRadius = 8
        taggedPostsView.clipsToBounds = true
    }
}

#Preview {
    ViewController()
}
