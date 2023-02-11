//
//  HomeInteractor.swift
//  SurfApp
//
//  Created by Вадим Кузьмин on 11.02.2023.
//

import Foundation

enum ScrollPosition {
    case last
    case first
}

protocol HomeBusinessLogic: AnyObject {
    func fetchDataSource()
    func updateDataSource(_ request: DataModel.Request)
    func addItemsToDataSource(at position: ScrollPosition)
}

final class HomeInteractor: HomeBusinessLogic {
    var presenter: HomePresentationLogic?

    private var initialDataSource = [
        Item(name: "iOS", state: .normal),
        Item(name: "Android", state: .normal),
        Item(name: "Design", state: .normal),
        Item(name: "Flutter", state: .normal),
        Item(name: "HR", state: .normal),
        Item(name: "QA", state: .normal),
        Item(name: "PM", state: .normal),
        Item(name: "Marketing", state: .normal),
        Item(name: "Web", state: .normal),
        Item(name: "System Analysis", state: .normal),
    ]
    private var dataSource = [Item]()

    func fetchDataSource() {
        dataSource = initialDataSource
        presenter?.presentDataSource(DataModel.Response(dataSource: dataSource), scrollPosition: nil, needReload: true)
    }

    func updateDataSource(_ request: DataModel.Request) {
        guard let index = initialDataSource.firstIndex(where: { $0.name == request.cellName }) else {return}
        initialDataSource[index].changeButtonState()
        var counter = index
        while counter < dataSource.count {
            print(dataSource[counter].name)
            dataSource[counter].changeButtonState()
            counter += dataSource.count
        }
        presenter?.presentDataSource(DataModel.Response(dataSource: dataSource), scrollPosition: nil, needReload: false)
    }

    func addItemsToDataSource(at position: ScrollPosition) {
        var scrollPosition: Int? = nil
        switch position {
        case .first:
            dataSource.insert(contentsOf: initialDataSource, at: 0)
            scrollPosition = initialDataSource.count
        case .last:
            dataSource.append(contentsOf: initialDataSource)
        }
        presenter?.presentDataSource(DataModel.Response(dataSource: dataSource), scrollPosition: scrollPosition, needReload: true)
    }
}
