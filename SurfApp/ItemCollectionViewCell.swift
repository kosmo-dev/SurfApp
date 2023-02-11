//
//  ItemCollectionViewCell.swift
//  SurfApp
//
//  Created by Вадим Кузьмин on 08.02.2023.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {

    func setupView(_ text: String) {
        button.setTitle(text, for: .normal)
        addSubview(button)
        makeConstraints()
        layoutIfNeeded()
        print(button.titleLabel?.frame.width)
    }

    let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .grayButton
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.layer.cornerRadius = 12
        button.setTitleColor(.black, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 24, bottom: 12, right: 24)

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    func makeConstraints() {
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
