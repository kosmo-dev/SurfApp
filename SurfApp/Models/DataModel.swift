//
//  DataModel.swift
//  SurfApp
//
//  Created by Вадим Кузьмин on 11.02.2023.
//

import UIKit

enum DataModel {
    struct Request {
        let cellIndex: Int
    }

    struct Response {
        let dataSource: [Item]
    }

    struct ViewModel {
        let viewModel: [Item]
    }
}

