//
//  Item.swift
//  SurfApp
//
//  Created by Вадим Кузьмин on 11.02.2023.
//

import UIKit

struct Item {
    let name: String
    private(set) var state: UIButton.State

    mutating func changeButtonState() {
        if state == .normal {
            state = .selected
        } else {
            state = .normal
        }
    }
}
