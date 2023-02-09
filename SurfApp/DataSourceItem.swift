//
//  DataSourceItem.swift
//  SurfApp
//
//  Created by Вадим Кузьмин on 08.02.2023.
//

import Foundation

enum DataSourceItem: Hashable {
    case filler(String)
    case title(String)
    case courses1(String)
    case description(String)
    case courses2(String)

    var filler: String? {
        if case .filler(let filler) = self {
            return filler
        } else {
            return nil
        }
    }

    var title: String? {
        if case .title(let title) = self {
            return title
        } else {
            return nil
        }
    }

    var courses1: String? {
        if case .courses1(let courses1) = self {
            return courses1
        } else {
            return nil
        }
    }

    var description: String? {
        if case .description(let description) = self {
            return description
        } else {
            return nil
        }
    }

    var courses2: String? {
        if case .courses2(let courses2) = self {
            return courses2
        } else {
            return nil
        }
    }
}
