//
//  HomeViewController.swift
//  SurfApp
//
//  Created by Вадим Кузьмин on 03.02.2023.
//

import UIKit

protocol HomeDisplayLogic: AnyObject {
    func displayData(_ viewModel: DataModel.ViewModel, position: Int?, needReload: Bool)
}

final class HomeViewController: UIViewController {

    var interactor: HomeBusinessLogic?
    private var dataSource = [Item]()
    private var dataSourceIsUpdating = false
    private var indexPathRow: Int = 0

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        initialSetup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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

    override func viewDidLoad() {
        super.viewDidLoad()

        interactor?.fetchDataSource()

        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewCell")

        let homeView = HomeView()
        self.view = homeView
        homeView.setupView(collectionView: collectionView)
        homeView.delegate = self
    }

    private func initialSetup() {
        let interactor = HomeInteractor()
        let presenter = HomePresenter()

        interactor.presenter = presenter
        presenter.viewController = self

        self.interactor = interactor
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let maxIndex = collectionView.indexPathsForVisibleItems.max()?.row else {return}
        guard let minIndex = collectionView.indexPathsForVisibleItems.min()?.row else {return}
        print(maxIndex)

        if minIndex == 0 && !dataSourceIsUpdating {
            interactor?.addItemsToDataSource(at: .first)
            dataSourceIsUpdating = true
            print("min index called")
        } else if maxIndex == dataSource.count - 1 && !dataSourceIsUpdating{
            interactor?.addItemsToDataSource(at: .last)
            dataSourceIsUpdating = true
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as? ItemCollectionViewCell {
            let item = dataSource[indexPath.row]
            cell.setupView(item.name, state: item.state, indexPathRow: indexPath.row)
            cell.delegate = self
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemInsets: CGFloat = 48
        let height: CGFloat = 44
        let width = dataSource[indexPath.item].name.size(withAttributes: [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .medium)
            ]).width + itemInsets
        return CGSize(width: width, height: height)
    }
}

extension HomeViewController: HomeViewDelegate {
    func didTappedsendApplicationButton() {
        let alertController = UIAlertController(title: "Поздравляем!", message: "Ваша заявка успешно отправлена!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Закрыть", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}

extension HomeViewController: ItemCollectionViewCellDelegate {
    func didTappedCellButton(_ name: String, indexPathRow: Int) {
        interactor?.updateDataSource(DataModel.Request(cellName: name))
        collectionView.scrollToItem(at: IndexPath(row: indexPathRow, section: 0), at: .left, animated: true)
    }
}

extension HomeViewController: HomeDisplayLogic {
    func displayData(_ viewModel: DataModel.ViewModel, position: Int?, needReload: Bool) {
        print(dataSource.count)
        dataSource = viewModel.viewModel
        guard needReload else {return}
        print(needReload)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            if let position = position {
                self.collectionView.scrollToItem(at: IndexPath(row: position, section: 0), at: .left, animated: false)
                print("scroll to item called")
            }
            self.dataSourceIsUpdating = false
        }
    }
}
