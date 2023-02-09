//
//  TextCollectionViewCell.swift
//  SurfApp
//
//  Created by Вадим Кузьмин on 08.02.2023.
//

import UIKit

enum LabelType {
    case title
    case description
}

final class TextCollectionViewCell: UICollectionViewCell {
    var view = UIView()
    var stackView = UIStackView()
    var titleLabel = UILabel()
    var descriptionLabel = UILabel()

    func setupView(titleLabelText: String?, descriptionLabelText: String?) {
        removeSubviewFromStackView()
        titleLabel.removeFromSuperview()
        descriptionLabel.removeFromSuperview()

        if titleLabelText != nil {
            self.clipsToBounds = true
            self.layer.cornerRadius = 25
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        backgroundColor = UIColor.white

        makeStackView(self, titleLabelText, descriptionLabelText)
    }

    private func makeLabel(_ text: String, _ labelType: LabelType) -> UILabel {
        let label = UILabel()
        label.text = text
        label.numberOfLines = 0

        switch labelType {
        case .title:
            label.textColor = UIColor.buttonSelected
            label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        case .description:
            label.textColor = UIColor.grayText
            label.font = UIFont.systemFont(ofSize: 14)
        }

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    private func removeSubviewFromStackView() {
        for subview in stackView.arrangedSubviews {
            stackView.removeArrangedSubview(subview)
        }
    }

    private func makeStackView(_ view: UIView, _ titleLabelText: String?, _ descriptionLabelText: String?) {
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 12

        if let titleLabelText {
            titleLabel = makeLabel(titleLabelText, .title)
            stackView.addArrangedSubview(titleLabel)
        }
        if let descriptionLabelText {
            descriptionLabel = makeLabel(descriptionLabelText, .description)
            stackView.addArrangedSubview(descriptionLabel)
        }

        view.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12)
        ])
    }
}
