//
//  ItemCollectionViewCell.swift
//  SurfApp
//
//  Created by Вадим Кузьмин on 08.02.2023.
//

import UIKit

protocol ItemCollectionViewCellDelegate: AnyObject {
    func didTappedCellButton(index: Int, isSelected: Bool)
}

final class ItemCollectionViewCell: UICollectionViewCell {
    // MARK: - Public Properties
    weak var delegate: ItemCollectionViewCellDelegate?

    // MARK: - Private Properties
    private var cellIndex: Int?

    // MARK: - Public Methods
    func setupView(_ text: String, state: UIButton.State, index: Int) {
        button.setTitle(text, for: .normal)
        cellIndex = index
        configureButton(for: state)

        addSubview(button)
        makeConstraints()
    }

    // MARK: - Private Methods
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

    private func configureButton(for state: UIButton.State) {
        if state == .selected {
            button.isSelected = true
            button.backgroundColor = .buttonSelected
        } else {
            button.isSelected = false
            button.backgroundColor = .grayButton
        }
    }

    @objc private func buttonTapped() {
        guard let cellIndex else {return}
        button.isSelected.toggle()
        if button.isSelected {
            button.backgroundColor = .buttonSelected
        } else {
            button.backgroundColor = .grayButton
        }
        delegate?.didTappedCellButton(index: cellIndex, isSelected: button.isSelected)
    }
}
