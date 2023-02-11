//
//  ItemCollectionViewCell.swift
//  SurfApp
//
//  Created by Вадим Кузьмин on 08.02.2023.
//

import UIKit

protocol ItemCollectionViewCellDelegate: AnyObject {
    func didTappedCellButton(_ name: String, indexPathRow: Int)
}

final class ItemCollectionViewCell: UICollectionViewCell {

    weak var delegate: ItemCollectionViewCellDelegate?

    private var cellName: String?
    private var indexPathRow: Int?

    func setupView(_ text: String, state: UIButton.State, indexPathRow: Int) {
        button.setTitle(text, for: .normal)
        if state == .selected {
            button.isSelected = true
            button.backgroundColor = .buttonSelected
        } else {
            button.isSelected = false
            button.backgroundColor = .grayButton
        }
        addSubview(button)
        makeConstraints()
        cellName = text
        self.indexPathRow = indexPathRow
    }

    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .grayButton
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.layer.cornerRadius = 12
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.white, for: .selected)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private func makeConstraints() {
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    @objc private func buttonTapped() {
        guard let cellName, let indexPathRow else {return}
        button.isSelected.toggle()
        if button.isSelected {
            button.backgroundColor = .buttonSelected
        } else {
            button.backgroundColor = .grayButton
        }
        print(cellName)
        delegate?.didTappedCellButton(cellName, indexPathRow: indexPathRow)
    }

}
