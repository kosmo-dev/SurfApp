//
//  HomeViewController.swift
//  SurfApp
//
//  Created by Вадим Кузьмин on 03.02.2023.
//

import UIKit

final class HomeViewController: UIViewController {

    private var dataSource = ["iOS", "Android", "Flutter", "Design", "HR", "QA", "PM", "Data Analysis", "Cybersecurity", "Marketing"]
    private let initialDataSource = ["iOS", "Android", "Flutter", "Design", "HR", "QA", "PM", "Data Analysis", "Cybersecurity", "Marketing"]

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.heightAnchor.constraint(equalToConstant: 44).isActive = true

        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewCell")

        let homeView = HomeView()
        self.view = homeView
        homeView.setupView(collectionView: collectionView)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let firstIndex = collectionView.indexPathsForVisibleItems.first?.row else {return}
//        guard let lastIndex = collectionView.indexPathsForVisibleItems.last?.row else {return}
        guard let maxIndex = collectionView.indexPathsForVisibleItems.max()?.row else {return}
//        guard let minIndex = collectionView.indexPathsForVisibleItems.min()?.row else {return}

        if firstIndex == 0 {
            dataSource.insert(contentsOf: initialDataSource, at: 0)
            DispatchQueue.main.async {
                collectionView.reloadData()
                self.collectionView.scrollToItem(at: IndexPath(row: self.initialDataSource.count, section: 0), at: .left, animated: false)
            }
        } else if maxIndex == dataSource.count - 1 {
            dataSource.append(contentsOf: initialDataSource)
            DispatchQueue.main.async {
                collectionView.reloadData()
            }
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as? ItemCollectionViewCell {
            let text = dataSource[indexPath.row]
            cell.setupView(text)
            cell.sizeToFit()
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        let spacing: CGFloat = 12
        let itemHeight: CGFloat = 44
        let itemsInRow: CGFloat = 3
        let totalSpacing: CGFloat = 2 * spacing + (itemsInRow - 1) * spacing
        let finalWidth = (width - totalSpacing) / itemsInRow
        return CGSize(width: finalWidth, height: itemHeight)
    }
}

