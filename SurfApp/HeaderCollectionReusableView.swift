//
//  HeaderCollectionReusableView.swift
//  SurfApp
//
//  Created by Вадим Кузьмин on 09.02.2023.
//

import UIKit

final class HeaderCollectionReusableView: UICollectionReusableView {
    let view = UIView()

    func setupView(type: String) {

        switch type {
        case SupplementaryViewKind.header:
            view.backgroundColor = UIColor.clear
        case SupplementaryViewKind.footer:
            view.backgroundColor = UIColor.white
        default:
            view.backgroundColor = UIColor.white
        }
        addSubview(view)

        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 400),
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
