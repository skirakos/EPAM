//
//  ViewController.swift
//  DownloadImages
//
//  Created by Seda Kirakosyan on 12.07.25.
//

import UIKit

struct Image: Decodable {
    var download_url: String
    var author: String
}

class ViewController: UIViewController {
    private var images_url: [Image] = []
    private var local_images: [URL] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(clearCache),
            name: UIApplication.didReceiveMemoryWarningNotification,
            object: nil
        )
    }
    func setupUI() {
        view.subviews.forEach { $0.removeFromSuperview() }
        
        let scrollView = UIScrollView()

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            stack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.75)
        ])

        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Clear cache", for: .normal)
        button.backgroundColor = .black
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 7
        button.addTarget(self, action: #selector(clearCache), for: .touchUpInside)
        stack.addArrangedSubview(button)
        
        
        for image in local_images {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFit
            iv.heightAnchor.constraint(equalToConstant: 200).isActive = true
            iv.image = UIImage(contentsOfFile: image.path)
            stack.addArrangedSubview(iv)
        }
    }
    @objc func clearCache() {
        let fileManager = FileManager.default
        let tempDir = fileManager.temporaryDirectory

        do {
            let files = try fileManager.contentsOfDirectory(at: tempDir, includingPropertiesForKeys: nil)
            for file in files {
                try fileManager.removeItem(at: file)
            }
            print("✅ All cached images deleted.")

            local_images.removeAll()
            DispatchQueue.main.async {
                self.setupUI()
            }
        } catch {
            print("⚠️ Failed to clear cache: \(error)")
        }
    }

    func downloadImages() {
        for image in self.images_url {
            if let url = URL(string: image.download_url) {
                URLSession.shared.downloadTask(with: url) { (tempUrl, response, error) in
                    if let error = error {
                        print("Error downloading: \(error)")
                        return
                    }
                    
                    guard let tempUrl = tempUrl else {
                        print("No temp file")
                        return
                    }
                    let fileManager = FileManager.default
                    let tmp = fileManager.temporaryDirectory
                    let fileName = UUID().uuidString + ".jpg"
                    let destinationUrl = tmp.appendingPathComponent(fileName)
                    
                    do {
                        try fileManager.moveItem(at: tempUrl, to: destinationUrl)
                        self.local_images.append(destinationUrl)
                        print("Saved image to: \(destinationUrl)")
                        
                        DispatchQueue.main.async {
                                self.setupUI()
                            }
                    } catch {
                        print("error saving file: \(error)")
                    }
                    
                }.resume()
            }
        }
    }
    func fetchData() {
        let url = URL(string: "https://picsum.photos/v2/list?page=1&limit=10")!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            guard let data = data else {
                print("No data")
                return
            }
            do {
                self.images_url = try JSONDecoder().decode([Image].self, from: data)
                for image in self.images_url {
                    print(image.download_url)
                }
                self.downloadImages()
            } catch {
                print("Error parsing: \(error)")
            }
        }.resume()
    }
}

#Preview {
    ViewController()
}
