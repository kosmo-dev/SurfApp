//
//  HomeViewController.swift
//  SurfApp
//
//  Created by Вадим Кузьмин on 03.02.2023.
//

import UIKit

final class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let homeView = HomeView()
        self.view = homeView
        homeView.setupView()
    }
}

