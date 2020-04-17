//
//  UIView+Layout.swift
//  Caturday
//
//  Created by Юрий Логинов on 17.04.2020.
//  Copyright © 2020 Юрий Логинов. All rights reserved.
//

import UIKit

extension UIView {
    func edgesToSuperview(insets: UIEdgeInsets = .zero) {
        guard let superview = superview else {
            return
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let left = leftAnchor.constraint(equalTo: superview.leftAnchor, constant: insets.left)
        let right = rightAnchor.constraint(equalTo: superview.rightAnchor, constant: insets.right)
        let top = topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top)
        let bottom = bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: insets.bottom)
        
        NSLayoutConstraint.activate([left, right, top, bottom])
    }

    func centerToSuperview() {
        guard let superview = superview else {
            return
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let cx = centerXAnchor.constraint(equalTo: superview.centerXAnchor)
        let cy = centerYAnchor.constraint(equalTo: superview.centerYAnchor)
        
        NSLayoutConstraint.activate([cx, cy])
    }
}

extension UIEdgeInsets {
    init(inset: CGFloat) {
        self.init(top: inset, left: inset, bottom: -inset, right: -inset)
    }
}
