//
//  HomeViewController.swift
//  SurfApp
//
//  Created by Вадим Кузьмин on 03.02.2023.
//

import UIKit

protocol HomeDisplayLogic: AnyObject {
    func displayData(_ viewModel: DataModel.ViewModel, needReload: Bool)
}

final class HomeViewController: UIViewController {

    // MARK: - Public Properties
    var interactor: HomeBusinessLogic?

    // MARK: - Private Properties
    private var dataSource = [Item]()
    private var viewFirstTimeLoaded = false
    private var numberOfCells = 100
    private let homeView = HomeView()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.heightAnchor.constraint(equalToConstant: 44).isActive = true

        return collectionView
    }()

    // MARK: - Initializers
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        initialSetup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        interactor?.fetchDataSource()

        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewCell")

        self.view = homeView
        homeView.setupView(collectionView: collectionView)
        homeView.delegate = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeView.makeHorizontalScrollView(dataSource: dataSource)
    }

    // MARK: - Private Methods
    private func initialSetup() {
        let interactor = HomeInteractor()
        let presenter = HomePresenter()

        interactor.presenter = presenter
        presenter.viewController = self

        self.interactor = interactor
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let maxIndex = collectionView.indexPathsForVisibleItems.max()?.row else {return}
        guard let minIndex = collectionView.indexPathsForVisibleItems.min()?.row else {return}

        if minIndex == 0 {
            collectionView.scrollToItem(at: IndexPath(row: numberOfCells / 2, section: 0), at: .left, animated: false)
        }
        if maxIndex == numberOfCells - 1 {
            collectionView.scrollToItem(at: IndexPath(row: numberOfCells / 2 + 5, section: 0), at: .left, animated: false)
        }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard viewFirstTimeLoaded else {return}
        collectionView.scrollToItem(at: IndexPath(row: numberOfCells / 2, section: 0), at: .left, animated: false)
        viewFirstTimeLoaded = true
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfCells
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as? ItemCollectionViewCell {
            let index = indexPath.row
            let item = dataSource[indexPath.row % dataSource.count]
            cell.setupView(item.name, state: item.state, index: index)
            cell.delegate = self
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemInsets: CGFloat = 48
        let height: CGFloat = 44

        let width = dataSource[indexPath.row % dataSource.count].name.size(withAttributes: [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .medium)
            ]).width + itemInsets
        return CGSize(width: width, height: height)
    }
}

// MARK: - HomeViewDelegate
extension HomeViewController: HomeViewDelegate {
    func didTappedSendApplicationButton() {
        let alertController = UIAlertController(title: "Поздравляем!", message: "Ваша заявка успешно отправлена!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Закрыть", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}

// MARK: - ItemCollectionViewCellDelegate
extension HomeViewController: ItemCollectionViewCellDelegate {
    func didTappedCellButton(index: Int, isSelected: Bool) {
        interactor?.updateDataSource(DataModel.Request(cellIndex: index))
        if isSelected {
            collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .left, animated: true)
        }
    }
}

// MARK: - HomeDisplayLogic
extension HomeViewController: HomeDisplayLogic {
    func displayData(_ viewModel: DataModel.ViewModel, needReload: Bool) {
        dataSource = viewModel.viewModel
        guard needReload else {return}
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            self.collectionView.reloadData()
        }
    }
}
