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
    private let tableView = UITableView()

    
    override func viewDidLoad() {
        super.viewDidLoad() 
        fetchData()
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        tableView.dataSource = self
        tableView.delegate = self

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(clearCache),
            name: UIApplication.didReceiveMemoryWarningNotification,
            object: nil
        )
    }
    func setupUI() {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Clear cache", for: .normal)
        button.backgroundColor = .black
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 7
        button.addTarget(self, action: #selector(clearCache), for: .touchUpInside)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            button.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.75),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
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
                    let fileName = url.lastPathComponent
                    let destinationUrl = tmp.appendingPathComponent(fileName)
                    
                    do {
                        try fileManager.moveItem(at: tempUrl, to: destinationUrl)
                        self.local_images.append(destinationUrl)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
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
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return local_images.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let url = local_images[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.contentView.subviews.forEach { $0.removeFromSuperview() }

        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(contentsOfFile: url.path)

        cell.contentView.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            imageView.widthAnchor.constraint(lessThanOrEqualTo: cell.contentView.widthAnchor, multiplier: 0.9),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])

        return cell
    }



    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
}

#Preview {
    ViewController()
}
