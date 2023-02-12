//
//  HomeInteractor.swift
//  SurfApp
//
//  Created by Вадим Кузьмин on 11.02.2023.
//

import Foundation

protocol HomeBusinessLogic: AnyObject {
    func fetchDataSource()
    func updateDataSource(_ request: DataModel.Request)
}

final class HomeInteractor: HomeBusinessLogic {
    var presenter: HomePresentationLogic?

    private var dataSource = [
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

    func fetchDataSource() {
        presenter?.presentDataSource(DataModel.Response(dataSource: dataSource), needReload: true)
    }

    func updateDataSource(_ request: DataModel.Request) {
        dataSource[request.cellIndex % dataSource.count].changeButtonState()
        presenter?.presentDataSource(DataModel.Response(dataSource: dataSource), needReload: false)
    }
}
