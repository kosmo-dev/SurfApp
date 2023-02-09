//
//  ItemCollectionViewCell.swift
//  SurfApp
//
//  Created by Вадим Кузьмин on 08.02.2023.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    var button = UIButton()
    let view = UIView()

    func setupView(_ text: String) {
        button.removeFromSuperview()
        view.removeFromSuperview()
        backgroundColor = UIColor.white
        makeButton(text)
    }

    private func makeButton(_ text: String) {

        view.backgroundColor = UIColor.white

        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])

        button.backgroundColor = UIColor.grayButton
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.layer.cornerRadius = 12
        button.setTitleColor(UIColor.black, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 24, bottom: 12, right: 24)
        view.addSubview(button)

        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 6),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -6),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
