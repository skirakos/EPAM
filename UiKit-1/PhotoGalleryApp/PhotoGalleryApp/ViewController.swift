//
//  ViewController.swift
//  PhotoGalleryApp
//
//  Created by Seda Kirakosyan on 23.06.25.
//

import UIKit

func dateFrom(_ string: String) -> Date {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter.date(from: string) ?? Date()
}

class ViewController: UIViewController {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    struct Photo {
        let image: UIImage
        let title: String
        let date: Date
        var isFavorite: Bool
    }
    var photosByYear: [Int: [Photo]] = [
        2024: [
            Photo(image: UIImage(named: "p1")!, title: "Sunset Beach", date: dateFrom("2024-06-01"), isFavorite: false),
            Photo(image: UIImage(named: "p2")!, title: "Mountain View", date: dateFrom("2024-06-01"), isFavorite: false),
            Photo(image: UIImage(named: "p1")!, title: "Sunset Beach", date: dateFrom("2024-06-01"), isFavorite: false),
            Photo(image: UIImage(named: "p2")!, title: "Mountain View", date: dateFrom("2024-06-01"), isFavorite: false),
            Photo(image: UIImage(named: "p1")!, title: "Sunset Beach", date: dateFrom("2024-06-01"), isFavorite: false),
            Photo(image: UIImage(named: "p2")!, title: "Mountain View", date: dateFrom("2024-06-01"), isFavorite: false)
        ],
        2023: [
            Photo(image: UIImage(named: "p3")!, title: "City Lights", date: dateFrom("2023-12-12"), isFavorite: true),
            Photo(image: UIImage(named: "p4")!, title: "Forest Walk", date: dateFrom("2023-11-23"), isFavorite: false),
            Photo(image: UIImage(named: "p_5")!, title: "Ocean Blue", date: dateFrom("2023-11-23"), isFavorite: false),
            Photo(image: UIImage(named: "p3")!, title: "City Lights", date: dateFrom("2023-12-12"), isFavorite: true),
            Photo(image: UIImage(named: "p4")!, title: "Forest Walk", date: dateFrom("2023-11-23"), isFavorite: false),
            Photo(image: UIImage(named: "p_5")!, title: "Ocean Blue", date: dateFrom("2023-11-23"), isFavorite: false)
        ]
    ]
    
    var sortedYears: [Int] {
        return photosByYear.keys.sorted(by: >)
    }
    
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 8, right: 16)
        layout.headerReferenceSize = CGSize(width: view.frame.width, height: 40)
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        setupCollectionView()
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeGesture.direction = .left
        collectionView.addGestureRecognizer(swipeGesture)

    }
    @objc func handleSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
        let location = gesture.location(in: collectionView)
        
        guard let indexPath = collectionView.indexPathForItem(at: location) else { return }
        
        let year = sortedYears[indexPath.section]
        photosByYear[year]?.remove(at: indexPath.item)
        
        if photosByYear[year]?.isEmpty == true {
            photosByYear.removeValue(forKey: year)
            collectionView.deleteSections(IndexSet(integer: indexPath.section))
        } else {
            collectionView.deleteItems(at: [indexPath])
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateItemSize()
        
        collectionView.frame = view.bounds
    }

    private func updateItemSize() {
        let isLandscape = view.bounds.width > view.bounds.height
        let columns: CGFloat = isLandscape ? 5 : 3
        let sectionInsets = layout.sectionInset.left + layout.sectionInset.right
        let spacing = layout.minimumInteritemSpacing * (columns - 1)
        let availableWidth = collectionView.bounds.width - sectionInsets - spacing
        let itemWidth = floor(availableWidth / columns)

        layout.itemSize = CGSize(width: itemWidth, height: itemWidth + 20)
        layout.invalidateLayout()
    }
 

    func setupCollectionView() {
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 12
        layout.headerReferenceSize = CGSize(width: view.frame.width, height: 40)
        
        collectionView.collectionViewLayout = layout
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: layout.minimumLineSpacing),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        let year = sortedYears[indexPath.section]
        let photo = photosByYear[year]![indexPath.item]
        cell.configure(with: photo)
        return cell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sortedYears.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let year = sortedYears[section]
        return photosByYear[year]?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as! HeaderCollectionReusableView
        header.configure(with: sortedYears[indexPath.section])
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 32, left: 16, bottom: 32, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        trailingSwipeActionsConfigurationForItemAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {

        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, completion in
            guard let self = self else { return }

            let year = self.sortedYears[indexPath.section]
            self.photosByYear[year]?.remove(at: indexPath.item)

            if self.photosByYear[year]?.isEmpty == true {
                self.photosByYear.removeValue(forKey: year)
                collectionView.deleteSections(IndexSet(integer: indexPath.section))
            } else {
                collectionView.deleteItems(at: [indexPath])
            }

            completion(true)
        }
        deleteAction.backgroundColor = .systemRed
        deleteAction.image = UIImage(systemName: "trash")

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    func collectionView(_ collectionView: UICollectionView,
                        contextMenuConfigurationForItemAt indexPath: IndexPath,
                        point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) { [weak self] _ in
                guard let self = self else { return }
                let year = self.sortedYears[indexPath.section]
                self.photosByYear[year]?.remove(at: indexPath.item)

                if self.photosByYear[year]?.isEmpty == true {
                    self.photosByYear.removeValue(forKey: year)
                    collectionView.deleteSections(IndexSet(integer: indexPath.section))
                } else {
                    collectionView.deleteItems(at: [indexPath])
                }
            }
            return UIMenu(title: "", children: [delete])
        }
    }
}

#Preview {
    ViewController()
}
