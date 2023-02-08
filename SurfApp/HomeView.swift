//
//  HomeView.swift
//  SurfApp
//
//  Created by Вадим Кузьмин on 07.02.2023.
//

import UIKit

final class HomeView: UIView {
    let footerContainerView = UIView()
    let stackView = UIStackView()
    var backgroundView = UIImageView()
    var collectionView = UICollectionView()

    // MARK: - Public Methods
    func setupView(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
        setupBackgroundImage()

        makeFooterView(backgroundView)
        makeStackView(footerContainerView)
        makeCollectionView(footerContainerView)
    }

    // MARK: - Private Methods
    private func makeFooterView(_ view: UIView) {
        footerContainerView.backgroundColor = UIColor.white
        view.addSubview(footerContainerView)

        footerContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            footerContainerView.heightAnchor.constraint(equalToConstant: 134),
            footerContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            footerContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            footerContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    private func makeStackView(_ view: UIView) {
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 24

        let button = makeButton("Отправить заявку")
        let label = makeLabel("Хочешь к нам?")

        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(button)

        view.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -58)
        ])
    }

    private func setupBackgroundImage() {
        guard let image = UIImage(named: "background") else {
            return
        }
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill

        addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        backgroundView = imageView
    }

    private func makeCollectionView(_ footerView: UIView) {

        collectionView.backgroundColor = UIColor.white

        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: footerView.topAnchor)
        ])
    }

    private func makeButton(_ title: String) -> UIButton {
        let button = UIButton()
        button.backgroundColor = UIColor(named: CustomColors.buttonSelected)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 30

        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 60)
        ])
        return button
    }

    private func makeLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
        label.textColor = UIColor(named: CustomColors.grayText)
        label.font = UIFont.systemFont(ofSize: 14)

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
