//
//  HeaderCollectionReusableView.swift
//  PhotoGalleryApp
//
//  Created by Seda Kirakosyan on 24.06.25.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "headerCollectionReusableView"
    private let label = UILabel()
    
    public func configure(with year: Int) {
        backgroundColor = .systemGray5
        label.text = "Year \(year)"
        addSubview(label)
        label.textAlignment = .left
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        label.font = .systemFont(ofSize: 17, weight: .bold)
    }
}

#Preview {
    ViewController()
}
