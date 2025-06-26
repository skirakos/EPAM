//
//  ViewController.swift
//  GymScheduleApp
//
//  Created by Seda Kirakosyan on 21.06.25.
//

import UIKit

func dateFrom(_ string: String) -> Date {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter.date(from: string)!
}

class ViewController: UIViewController {
    let tableView = UITableView()
    
    var data: [DailySchedule] = [
        DailySchedule(date: "Friday 21 Feb 2025",
                      classes: [ GymClass(name: "Stretching",
                                        time: "18:00",
                                        duration: "55m",
                                        trainer: Trainer(fullName: "Agata Wójcik", photoName: "picture_1"),
                                        isRegistered: true)]),
        
        DailySchedule(date: "Saturday 22 Feb 2025",
                      classes: [ GymClass(name: "Stretching",
                                        time: "10:00",
                                        duration: "55m",
                                        trainer: Trainer(fullName: "Ewa Pietrzyk", photoName: "picture_3"),
                                        isRegistered: true),
                                GymClass(name: "Pilates",
                                                  time: "10:00",
                                                  duration: "55m",
                                                  trainer: Trainer(fullName: "Ewa Pietrzyk", photoName: "picture_3"),
                                                  isRegistered: false)]),
        DailySchedule(date: "Saturday 24 Feb 2025",
                      classes: [ GymClass(name: "Stretching",
                                        time: "0:00",
                                        duration: "55m",
                                        trainer: Trainer(fullName: "Agata Wójcik", photoName: "picture_1"),
                                        isRegistered: false)]),
        DailySchedule(date: "Saturday 26 Feb 2025",
                      classes: [ GymClass(name: "Stretching",
                                        time: "10:00",
                                        duration: "55m",
                                        trainer: Trainer(fullName: "Emanuel Smith", photoName: "picture_2"),
                                        isRegistered: true),
                                GymClass(name: "Pilates",
                                                  time: "10:00",
                                                  duration: "55m",
                                                  trainer: Trainer(fullName: "Ewa Pietrzyk", photoName: "ewa"),
                                                  isRegistered: false)]),
        DailySchedule(date: "Saturday 27 Feb 2025",
                      classes: [ GymClass(name: "Stretching",
                                        time: "10:00",
                                        duration: "55m",
                                        trainer: Trainer(fullName: "Emanuel Smith", photoName: "picture_2"),
                                        isRegistered: true),
                                GymClass(name: "Pilates",
                                                  time: "10:00",
                                                  duration: "55m",
                                                  trainer: Trainer(fullName: "Ewa Pietrzyk", photoName: "picture_3"),
                                                  isRegistered: false)]),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.register(GymClassCell.self, forCellReuseIdentifier: GymClassCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        setupTableView()
        
    }
    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

}
struct DailySchedule {
    let date: String
    var classes: [GymClass]
}
struct Trainer {
    let fullName: String
    let photoName: String
}
struct GymClass {
    let name: String
    let time: String
    let duration: String
    let trainer: Trainer
    var isRegistered: Bool
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].classes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let session = data[indexPath.section].classes[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GymClassCell.identifier, for: indexPath) as? GymClassCell else {
            return UITableViewCell()
        }
        cell.configure(with: session)
        
        return cell
    }
    //for every section's title
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.systemGroupedBackground

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = data[section].date
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.systemBlue

        headerView.addSubview(label)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            label.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -4)
        ])

        return headerView
    }
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            data[indexPath.section].classes.remove(at: indexPath.row)

            if data[indexPath.section].classes.isEmpty {
                data.remove(at: indexPath.section)
                tableView.deleteSections(IndexSet(integer: indexPath.section), with: .automatic)
            } else {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }
}
#Preview {
    ViewController()
}
