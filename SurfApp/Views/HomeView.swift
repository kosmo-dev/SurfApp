//
//  HomeView.swift
//  SurfApp
//
//  Created by Вадим Кузьмин on 09.02.2023.
//

import UIKit

protocol HomeViewDelegate: AnyObject {
    func didTappedSendApplicationButton()
}

final class HomeView: UIView {
    // MARK: - Public properties
    weak var delegate: HomeViewDelegate?

    // MARK: - Public Methods
    func setupView(collectionView: UICollectionView) {
        addSubview(backgroundImageView)
        addSubview(scrollView)
        scrollView.addSubview(scrollViewContainer)
        scrollViewContainer.addArrangedSubview(headerView)
        scrollViewContainer.addArrangedSubview(titleView)
        scrollViewContainer.addArrangedSubview(firstDescriptionView)
        scrollViewContainer.addArrangedSubview(collectionView)
        scrollViewContainer.addArrangedSubview(secondDescriptionView)
        addSubview(footerElementsView)

        makeConstraints(collectionView: collectionView)
    }

    func makeFirstHorizontalStackView(dataSource: [Item]) {
        guard frame.width != 0 && !didMakeLayout else {return}
        availableHeight = frame.height
        didMakeLayout = true
        let result = makeView(for: dataSource, startIndex: 0)
        let view = result.0
        scrollViewContainer.addArrangedSubview(view)
        makeSecondHorizontalStackView(index: result.1, dataSource: dataSource)
    }

    func makeSecondHorizontalStackView(index: Int, dataSource: [Item]) {
        let view = makeView(for: dataSource, startIndex: index).0
        scrollViewContainer.addArrangedSubview(view)
        scrollViewContainer.addArrangedSubview(footerView)
    }

    // MARK: - Private Properties
    private var didMakeLayout = false
    private var availableHeight: CGFloat = 0

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let scrollViewContainer: UIStackView = {
        let view = UIStackView()

        view.axis = .vertical
        view.spacing = 0

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let headerView: UIView = {
        let view = UIView()

        view.backgroundColor = .clear

        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 460).isActive = true
        return view
    }()

    private let titleView: UIView = {
        let label = UILabel()
        let view = UIView()

        label.text = "Стажировка в Surf"
        label.textColor = .buttonSelected
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)

        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        view.layer.maskedCorners = CACornerMask([.layerMinXMinYCorner, .layerMaxXMinYCorner])
        view.addSubview(label)

        view.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        return view
    }()

    private let firstDescriptionView: UIView = {
        let label = UILabel()
        let view = UIView()

        label.text = "Работай над реальными задачами под руководством опытного наставника и получи возможность стать частью команды мечты."
        label.textColor = .grayText
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)

        view.backgroundColor = .white
        view.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12)
        ])
        return view
    }()

    private let secondDescriptionView: UIView = {
        let label = UILabel()
        let view = UIView()

        label.text = "Получай стипендию, выстраивай удобный график, работай на современном железе."
        label.textColor = .grayText
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)

        view.backgroundColor = .white
        view.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12)
        ])
        return view
    }()

    private let footerView: UIView = {
        let view = UIView()

        view.backgroundColor = UIColor.white

        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 380).isActive = true
        return view
    }()

    private let footerElementsView: UIView = {
        let view = UIView()
        let stackView = UIStackView()
        let button = UIButton()
        let label = UILabel()

        view.backgroundColor = UIColor.white

        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 24

        button.backgroundColor = UIColor.buttonSelected
        button.setTitle("Отправить заявку", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(sendApplicationButtonTapped), for: .touchUpInside)

        label.text = "Хочешь к нам?"
        label.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
        label.textColor = UIColor.grayText
        label.font = UIFont.systemFont(ofSize: 14)

        view.addSubview(stackView)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(button)

        view.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 60),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -58)
        ])
        return view
    }()

    private let backgroundImageView: UIImageView = {
        guard let image = UIImage(named: "background") else {
            return UIImageView()
        }
        let view = UIImageView()
        view.image = image
        view.contentMode = .scaleAspectFill

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Private Methods
    private func makeView(for dataSource: [Item], startIndex: Int) -> (UIView, Int) {
        var availableWidth = frame.width
        let view = UIView()
        view.backgroundColor = .white

        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.heightAnchor.constraint(equalToConstant: 44).isActive = true

        var dataIndex = 0

        for i in startIndex...dataSource.count {
            dataIndex = i
            let item = dataSource[i]
            let itemInsets: CGFloat = 48
            let height: CGFloat = 44
            let width = item.name.size(withAttributes: [
                    NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .medium)
                ]).width + itemInsets
            if availableWidth - width > width {
                let cell = ItemCollectionViewCell(frame: CGRect(x: 0, y: 0, width: width, height: height))
                cell.setupView(item.name, state: item.state, index: i)
                cell.translatesAutoresizingMaskIntoConstraints = false
                cell.widthAnchor.constraint(equalToConstant: width).isActive = true
                stackView.addArrangedSubview(cell)
            } else {
                let fillerView = UIView(frame: CGRect(x: 0, y: 0, width: availableWidth - width, height: height))
                fillerView.translatesAutoresizingMaskIntoConstraints = false
                stackView.addArrangedSubview(fillerView)
                break
            }
            availableWidth -= width
        }

        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12)
        ])
        availableHeight = availableHeight - view.bounds.height
        return (view, dataIndex)
    }

    private func makeConstraints(collectionView: UICollectionView) {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),

            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            footerElementsView.leadingAnchor.constraint(equalTo: leadingAnchor),
            footerElementsView.trailingAnchor.constraint(equalTo: trailingAnchor),
            footerElementsView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    @objc private func sendApplicationButtonTapped() {
        delegate?.didTappedSendApplicationButton()
    }
}