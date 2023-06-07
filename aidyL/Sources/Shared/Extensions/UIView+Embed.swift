//
//  UIView+Embed.swift
//  aidyL
//
//  Created by Romain Bousquet on 3/6/2023.
//

import UIKit

extension UIView {
    func embed(_ subview: UIView, inset: CGFloat = 0) {
        embed(
            subview,
            topInset: inset,
            leadingInset: inset,
            bottomInset: inset,
            trailingInset: inset
        )
    }
    
    func embed(
        _ subview: UIView,
        topInset: CGFloat = 0,
        leadingInset: CGFloat = 0,
        bottomInset: CGFloat = 0,
        trailingInset: CGFloat = 0
    ) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: topAnchor, constant: topInset),
            subview.leftAnchor.constraint(equalTo: leftAnchor, constant: leadingInset),
            bottomAnchor.constraint(equalTo: subview.bottomAnchor, constant: bottomInset),
            rightAnchor.constraint(equalTo: subview.rightAnchor, constant: trailingInset)
        ])
    }
}
