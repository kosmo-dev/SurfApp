//
//  HomePresenter.swift
//  SurfApp
//
//  Created by Вадим Кузьмин on 11.02.2023.
//

import Foundation

protocol HomePresentationLogic {
    func presentDataSource(_ response: DataModel.Response, needReload: Bool)
}

final class HomePresenter: HomePresentationLogic {
    weak var viewController: HomeDisplayLogic?
    
    func presentDataSource(_ response: DataModel.Response, needReload: Bool) {
        viewController?.displayData(DataModel.ViewModel(viewModel: response.dataSource), needReload: needReload)
    }
}
