//
//  LoaderCell.swift
//  aidyL
//
//  Created by Romain Bousquet on 5/6/2023.
//

import Foundation
import UIKit

final class LoaderCell: UITableViewCell {
    private let indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        indicator.color = .gray
        indicator.backgroundColor = .white
        return indicator
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        indicatorView.startAnimating()
    }
}

private extension LoaderCell {
    func setup() {
        selectionStyle = .none
        
        contentView.addSubview(indicatorView)
        NSLayoutConstraint.activate([
            indicatorView.heightAnchor.constraint(equalToConstant: 80),
            indicatorView.topAnchor.constraint(equalTo: contentView.topAnchor),
            indicatorView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: indicatorView.bottomAnchor),
            contentView.rightAnchor.constraint(equalTo: indicatorView.rightAnchor)
        ])
    }
}
