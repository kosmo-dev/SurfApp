//
//  FillerCollectionViewCell.swift
//  SurfApp
//
//  Created by Вадим Кузьмин on 08.02.2023.
//

import UIKit

class FillerCollectionViewCell: UICollectionViewCell {
    let cellView = UIView()

    func setupView(type: String) {

        if type == "clear" {
            cellView.backgroundColor = UIColor.clear
        } else {
            cellView.backgroundColor = UIColor.white
        }
    }
}
