//
//  CustomCollectionViewCell.swift
//  PhotoGalleryApp
//
//  Created by Seda Kirakosyan on 24.06.25.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    static let identifier = "cell"
    
    private let imageView = UIImageView()
    private let button = UIButton()
    private var photo: ViewController.Photo?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        contentView.addSubview(imageView)
        
        button.tintColor = .white
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        imageView.addSubview(button)
    }

    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 120),
            
            button.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8),
            button.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -8)
        ])
    }

    func configure(with photo: ViewController.Photo) {
        self.photo = photo
        imageView.image = photo.image
        let iconName = photo.isFavorite ? "heart.fill" : "heart"
        button.setImage(UIImage(systemName: iconName), for: .normal)
    }

    @objc private func buttonTapped() {
        guard var photo = photo else { return }
        photo.isFavorite.toggle()
        configure(with: photo)
        let message = photo.isFavorite ? "Marked <<\(photo.title)>> as Favorite!" : "Removed <<\(photo.title)>> from Favorites."

        if let vc = self.parentViewController() as? ViewController {
            vc.showAlert(message: message)
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
