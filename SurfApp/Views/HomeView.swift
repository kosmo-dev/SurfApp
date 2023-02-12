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
        addSubview(bottomFillerView)
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

    func makeHorizontalScrollView(dataSource: [Item]) {
        guard frame.width != 0 && !didMakeLayout else {return}
        didMakeLayout = true
        let view = UIView()
        view.backgroundColor = .white

        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInset.left = 20
        scrollView.contentInset.right = 20

        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 12
        verticalStackView.distribution = .fill

        let stackViewTuple = makeStackView(for: dataSource, startIndex: 0)
        let firstStackView = stackViewTuple.0

        let secondStackViewTuple = makeStackView(for: dataSource, startIndex: stackViewTuple.1)
        let secondStackView = secondStackViewTuple.0

        for i in (secondStackViewTuple.1)..<dataSource.count {
            let item = dataSource[i]
            let itemInsets: CGFloat = 48
            let height: CGFloat = 44
            let width = item.name.size(withAttributes: [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .medium)
            ]).width + itemInsets
            let cell = makeCellView(item: item, width: width, height: height)
            firstStackView.layoutIfNeeded()
            secondStackView.layoutIfNeeded()
            let firstWidth = firstStackView.frame.width
            let secondWidth = secondStackView.frame.width
            if firstWidth > secondWidth {
                secondStackView.addArrangedSubview(cell)
            } else {
                firstStackView.addArrangedSubview(cell)
            }
        }

        let footerHeight: CGFloat = frame.height - safeAreaInsets.top - 400

        scrollViewContainer.addArrangedSubview(view)
        view.addSubview(scrollView)
        scrollView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(firstStackView)
        verticalStackView.addArrangedSubview(secondStackView)
        firstStackView.addArrangedSubview(makeFillerView())
        secondStackView.addArrangedSubview(makeFillerView())
        scrollViewContainer.addArrangedSubview(footerView)

        view.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        firstStackView.translatesAutoresizingMaskIntoConstraints = false
        secondStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 110),

            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 110),

            verticalStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            footerView.heightAnchor.constraint(equalToConstant: footerHeight)
        ])
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

    private let bottomFillerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Private Methods
    private func makeStackView(for dataSource: [Item], startIndex: Int) -> (UIStackView, Int) {
        var availableWidth = frame.width

        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.heightAnchor.constraint(equalToConstant: 44).isActive = true

        var dataIndex = 0

        for i in startIndex..<dataSource.count {
            dataIndex = i
            let item = dataSource[i]
            let itemInsets: CGFloat = 48
            let height: CGFloat = 44
            let width = item.name.size(withAttributes: [
                    NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .medium)
                ]).width + itemInsets
            if availableWidth - width > width {
                let cell = makeCellView(item: item, width: width, height: height)
                stackView.addArrangedSubview(cell)
            } else {
                break
            }
            availableWidth -= width
        }
        return (stackView, dataIndex)
    }

    private func makeCellView(item: Item, width: CGFloat, height: CGFloat) -> ItemCollectionViewCell {
        let cell = ItemCollectionViewCell(frame: CGRect(x: 0, y: 0, width: width, height: height))
        cell.setupView(item.name, state: item.state, index: 0)
        cell.translatesAutoresizingMaskIntoConstraints = false
        cell.widthAnchor.constraint(equalToConstant: width).isActive = true
        return cell
    }

    private func makeFillerView() -> UIView {
        let fillerView = UIView()
        fillerView.translatesAutoresizingMaskIntoConstraints = false
        fillerView.setContentCompressionResistancePriority(UILayoutPriority(252), for: .horizontal)
        return fillerView
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
            footerElementsView.bottomAnchor.constraint(equalTo: bottomAnchor),

            bottomFillerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomFillerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomFillerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomFillerView.heightAnchor.constraint(equalToConstant: 225)
        ])
    }

    @objc private func sendApplicationButtonTapped() {
        delegate?.didTappedSendApplicationButton()
    }
}
