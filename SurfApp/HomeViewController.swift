//
//  HomeViewController.swift
//  SurfApp
//
//  Created by Вадим Кузьмин on 03.02.2023.
//

import UIKit

final class HomeViewController: UIViewController {
    private var collectionView = UICollectionView()

    // MARK: - Live Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let homeView = HomeView(frame: view.bounds)
        view.addSubview(homeView)

        homeView.setupView(collectionView)
    }
}

