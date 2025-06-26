//
//  GymClassCell.swift
//  GymScheduleApp
//
//  Created by Seda Kirakosyan on 21.06.25.
//

import UIKit

class GymClassCell: UITableViewCell {
    static let identifier = "GymClassCell"
    let trainerImageView = UIImageView()
    let button = UIButton(type: .system)
    
    var nameLabel = UILabel()
    var dateLabel = UILabel()
    var durationLabel = UILabel()
    var trainerLabel = UILabel()
    var trainerImageName: String?
    var timeLabel = UILabel()
    var buttonLabel = UILabel()
    var isRegistered: Bool = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupButton() {
        
        contentView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 37, weight: .light)
        
        button.layer.cornerRadius = 28
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.titleLabel?.textColor = .systemBlue
        button.tintColor = .systemBlue
        button.titleLabel?.textAlignment = .center
        
        
        let action = UIAction { _ in
            if (self.isRegistered) {
                self.button.backgroundColor = .white
                self.button.setImage(UIImage(systemName: "plus"), for: .normal)
                self.button.tintColor = .systemBlue
                self.isRegistered = false
                if let viewController = self.parentViewController() {
                    let alert = UIAlertController(title: "", message: "You have just cancelled \(String(describing: self.nameLabel.text ?? "")).", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    viewController.present(alert, animated: true)
                }
            }
            else {
                self.button.backgroundColor = .systemBlue
                self.button.setImage(UIImage(systemName: "xmark"), for: .normal)
                self.button.tintColor = .white
                self.isRegistered = true
                if let viewController = self.parentViewController() {
                    let alert = UIAlertController(title: "", message: "You have registered to \(String(describing: self.nameLabel.text ?? "")), see you there!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    viewController.present(alert, animated: true)
                }
            }
        }
        self.button.addAction(action, for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            button.widthAnchor.constraint(equalToConstant: 56),
            button.heightAnchor.constraint(equalToConstant: 56),
        ])
    }
    func setupViews() {
        [nameLabel, dateLabel, durationLabel, trainerLabel, timeLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.font = .systemFont(ofSize: 14)
        }
        trainerImageView.translatesAutoresizingMaskIntoConstraints = false
        trainerImageView.setContentHuggingPriority(.required, for: .horizontal)
        trainerImageView.setContentHuggingPriority(.required, for: .vertical)
        trainerImageView.layer.cornerRadius = 14
        trainerImageView.clipsToBounds = true
        trainerImageView.contentMode = .scaleAspectFill
        contentView.addSubview(trainerImageView)
        
        
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        nameLabel.textColor = .label

        timeLabel.font = UIFont.systemFont(ofSize: 24)
        timeLabel.textColor = .secondaryLabel

        durationLabel.font = UIFont.systemFont(ofSize: 14)
        durationLabel.textColor = .systemGray

        trainerLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        trainerLabel.textColor = .systemIndigo

        dateLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        dateLabel.textColor = .systemGray2
        
        NSLayoutConstraint.activate([
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),

            nameLabel.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 12),
            nameLabel.topAnchor.constraint(equalTo: timeLabel.topAnchor),

            durationLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor),
            durationLabel.leadingAnchor.constraint(equalTo: timeLabel.leadingAnchor),
            
            trainerLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            trainerLabel.leadingAnchor.constraint(equalTo: trainerImageView.trailingAnchor, constant: 6),
            
            trainerImageView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            trainerImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            trainerImageView.widthAnchor.constraint(equalToConstant: 28),
            trainerImageView.heightAnchor.constraint(equalToConstant: 28),

            trainerLabel.leadingAnchor.constraint(equalTo: trainerImageView.trailingAnchor, constant: 8),
            trainerLabel.centerYAnchor.constraint(equalTo: trainerImageView.centerYAnchor),

            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: trainerImageView.bottomAnchor, constant: 12),


            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: trainerLabel.bottomAnchor, constant: 12)
        ])
    }

    func configure(with session: GymClass) {
        self.nameLabel.text = session.name
        self.durationLabel.text = session.duration
        self.trainerLabel.text = session.trainer.fullName
        self.timeLabel.text = session.time
        self.isRegistered = session.isRegistered
        if isRegistered {
            button.setImage(UIImage(systemName: "xmark"), for: .normal)
            button.backgroundColor = .systemBlue
            button.tintColor = .white
            
        }
        else {
            button.setImage(UIImage(systemName: "plus"), for: .normal)
            button.backgroundColor = .white
            button.tintColor = .systemBlue
        }
        self.trainerImageName = session.trainer.photoName
        self.isRegistered = session.isRegistered
        self.trainerImageName = session.trainer.photoName
        
        if let image = UIImage(named: session.trainer.photoName) {
            trainerImageView.image = image
        } else {
            trainerImageView.image = UIImage(systemName: "person.circle.fill")
        }
    }
}
extension UIResponder {
    func parentViewController() -> UIViewController? {
        return next as? UIViewController ?? next?.parentViewController()
    }
}

#Preview {
    ViewController()
}
