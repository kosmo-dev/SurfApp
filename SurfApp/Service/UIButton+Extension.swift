//
//  UIButton+Extension.swift
//  SurfApp
//
//  Created by Вадим Кузьмин on 11.02.2023.
//

import UIKit

extension UIButton {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        animate()
    }

    func animate() {
        isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.08, delay: 0, options: .curveLinear) { [weak self] in
            guard let self else {return}
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        } completion: { [weak self] _ in
            guard let self else {return}
            UIView.animate(withDuration: 0.08, delay: 0, options: .curveLinear) {
                self.transform = CGAffineTransform.identity
            } completion: { _ in
                self.isUserInteractionEnabled = true
            }
        }
    }
}
