//
//  ViewController.swift
//  TopRatedMovies
//
//  Created by Seda Kirakosyan on 09.07.25.
//

import UIKit
struct MovieResponse: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    let id: Int
    let name: String
    let overview: String
    let poster_path: String?
    let backdrop_path: String?
    let first_air_date: String
    let origin_country: [String]
    let popularity: Double
//    let number_of_seasons: Int
//    let number_of_episodes: Int
    let vote_average: Double
}

enum NetworkError : Error {
    case urlError
    case decodingError
    case noData
    case badURL
}

class ViewController: UIViewController {
    private let tableView: UITableView = .init()
    private var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        Task {
            let result = await fetchData()

            switch result {
            case .success(let fetchedMovies):
                self.movies = fetchedMovies
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 400
    }
    
    
    func fetchData() async -> Result<[Movie], Error> {
        var components = URLComponents(string: "https://api.themoviedb.org/3/tv/top_rated")
        components?.queryItems = [
            URLQueryItem(name: "api_key", value: "7481bbcf1fcb56bd957cfe9af78205f3"),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1")
        ]

        guard let url = components?.url else {
            return .failure(NetworkError.badURL)
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            if let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode != 200 {
                return .failure(NetworkError.noData)
            }

            let decoded = try JSONDecoder().decode(MovieResponse.self, from: data)
            return .success(decoded.results)
        } catch {
            return .failure(error)
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }
        cell.configure(with: movies[indexPath.row])
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
}

#Preview {
    ViewController()
}
