//
//  ViewController.swift
//  ListOfRecentSearches
//
//  Created by Seda Kirakosyan on 21.07.25.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    private let userDefaults = UserDefaults.standard
    private var recentSearches: [String] = []
//    private var recentSearches: [String] = [] {
//        didSet {
//            tableView.reloadData()
//            
//        }
//    }
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Search"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Search here..."
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        recentSearches.removeAll()
        print("recentSearches.count: \(recentSearches.count)")
        recentSearches = userDefaults.stringArray(forKey: "recentSearches") ?? []
        view.addSubview(label)
        view.addSubview(searchBar)
        view.addSubview(tableView)
//        searchBar.backgroundColor = .red
//        tableView.backgroundColor = .blue
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            searchBar.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16),
            searchBar.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: 0.75),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recentSearches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = recentSearches[indexPath.row]
        return cell
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        recentSearches.removeAll()
        guard let term = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines), !term.isEmpty else {
            return
        }
        
        if recentSearches.count >= 5 {
            recentSearches.removeLast(1)
        }
        recentSearches.insert(term, at: 0)
        userDefaults.set(recentSearches, forKey: "recentSearches")
        searchBar.text = ""
        searchBar.resignFirstResponder()
        
        tableView.reloadData()
    }
}

#Preview {
    ViewController()
}
