//
//  ViewController.swift
//  ImageConfig
//
//  Created by Seda Kirakosyan on 12.07.25.
//

import UIKit

struct Config: Codable {
    let title: String
    let filterKeyword: String
    let maxImages: Int
}

class ViewController: UIViewController {
    private var config: Config = .init(
        title: "",
        filterKeyword: "",
        maxImages: 2,
    )
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 21, weight: .bold)
        label.tintColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let allImageNames = [
        "gallery_1",
        "gallery_2",
        "gallery_3",
        "gallery_4",
        "gallery_5",
        "museum_1",
        "museum_2",
        "museum_3",
        "museum_4"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        loadConfig()
        setupUI()
    }
    
    func loadConfig() {
        guard let url = Bundle.main.url(forResource: "Config", withExtension: "json") else {
            print("Config file not found")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let config = try JSONDecoder().decode(Config.self, from: data)
            self.config = config
            print("Config loaded: \(config)")
        } catch {
            print("error loading config: \(error)")
            return
        }
    }
    
    func setupUI() {
        label.text = config.title
        view.addSubview(label)
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                        
                        scrollView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        let filteredNames: [String] = allImageNames
            .filter { $0.contains(config.filterKeyword) }
        print("filteredNames: \(filteredNames)")
        
        let images: [UIImageView] = filteredNames.compactMap {
            let imageView = UIImageView(image: UIImage(named: $0))
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
            if stackView.arrangedSubviews.count >= config.maxImages {
                return imageView
            }
            stackView.addArrangedSubview(imageView)
            return imageView
            
        }
        
        
        
    }
}

#Preview {
    ViewController()
}
