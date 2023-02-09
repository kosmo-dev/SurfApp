//
//  HomeViewController.swift
//  SurfApp
//
//  Created by Вадим Кузьмин on 03.02.2023.
//

import UIKit

enum DataSourceSection {
    case filler
    case title
    case courses1
    case description
    case courses2
}


final class HomeViewController: UIViewController {

    private var collectionView: UICollectionView?

    let clearCollectionViewCellReuseId = "clearCollectionViewCellReuseId"
    let textCollectionViewCellReuseId = "textCollectionViewCellReuseId"
    let itemCollectionViewCellReuseId = "itemCollectionViewCellReuseId"

    private var courses1: [DataSourceItem] = [.courses1("iOS"), .courses1("Android"), .courses1("Flutter"), .courses1("Design"), .courses1("QA"), .courses1("PM"), .courses1("HR"), .courses1("System Analysis"), .courses1("Security")]
    private var courses2: [DataSourceItem] = [.courses2("iOS"), .courses2("Android"), .courses2("Flutter"), .courses2("Design"), .courses2("QA"), .courses2("PM"), .courses2("HR"), .courses2("System Analysis"), .courses2("Security")]

    private typealias DataSource = UICollectionViewDiffableDataSource<DataSourceSection, DataSourceItem>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<DataSourceSection, DataSourceItem>

    lazy private var dataSource = configureDataSource()

    private var sections = [DataSourceSection]()

    // MARK: - Live Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let homeView = HomeView(frame: view.bounds)
        view.addSubview(homeView)

        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 250, height: 250), collectionViewLayout: createLayout())

        makeCollectionView()

        guard let collectionView else {return}

        homeView.setupView(collectionView)

        collectionView.register(FillerCollectionViewCell.self, forCellWithReuseIdentifier: clearCollectionViewCellReuseId)
        collectionView.register(TextCollectionViewCell.self, forCellWithReuseIdentifier: textCollectionViewCellReuseId)
        collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: itemCollectionViewCellReuseId)

        applySnaphot()
    }

    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let sectionItem = self.sections[sectionIndex]

            switch sectionItem {
            case .filler:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/3))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section

            case .title:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(130))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section

            case .courses1, .courses2:
                let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .estimated(44))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                return section
            case .description:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(64))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
            }
        }
        return layout
    }

    private func makeCollectionView() {

        guard let collectionView else {return}

//        collectionView.backgroundColor = UIColor.clear
        collectionView.backgroundColor = UIColor.white

        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func configureDataSource() -> DataSource? {
        guard let collectionView else {return nil}
        let dataSource = DataSource(collectionView: collectionView) { [weak self] (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
            guard let self else {return nil}
            let section = self.sections[indexPath.section]

            var collectionViewCell = UICollectionViewCell()

            switch section {
            case .filler:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.clearCollectionViewCellReuseId, for: indexPath) as? FillerCollectionViewCell {
                    cell.setupView(type: "clear")
                    collectionViewCell = cell
                }
            case .title:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.textCollectionViewCellReuseId, for: indexPath) as? TextCollectionViewCell {
                    cell.setupView(titleLabelText: "Стажировка в Surf", descriptionLabelText: itemIdentifier.title)
                    collectionViewCell = cell
                }
            case .courses1:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.itemCollectionViewCellReuseId, for: indexPath) as? ItemCollectionViewCell {
                    cell.setupView(itemIdentifier.courses1 ?? "")
                    collectionViewCell = cell
                }
            case .courses2:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.itemCollectionViewCellReuseId, for: indexPath) as? ItemCollectionViewCell {
                    cell.setupView(itemIdentifier.courses2 ?? "")
                    collectionViewCell = cell
                }
            case .description:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.textCollectionViewCellReuseId, for: indexPath) as? TextCollectionViewCell {
                    cell.setupView(titleLabelText: nil, descriptionLabelText: itemIdentifier.description)
                    collectionViewCell = cell
                }
            }
            return collectionViewCell
        }
        return dataSource
    }

    func applySnaphot() {
        var snapshot = NSDiffableDataSourceSnapshot<DataSourceSection, DataSourceItem>()
        snapshot.appendSections([.filler, .title, .courses1, .description, .courses2])
        snapshot.appendItems([.filler("clear")], toSection: .filler)
        snapshot.appendItems([.title("Работай над реальными задачами под руководством опытного наставника и получи возможность стать частью команды мечты.")], toSection: .title)
        snapshot.appendItems(courses1, toSection: .courses1)
        snapshot.appendItems([.description("Получай стипендию, выстраивая удобный график, работай на современном железе.")], toSection: .description)
        snapshot.appendItems(courses2, toSection: .courses2)

        sections = snapshot.sectionIdentifiers

        guard let dataSource else {return}
        dataSource.apply(snapshot)
    }
}

