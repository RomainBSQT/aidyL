//
//  ProfileCell.swift
//  aidyL
//
//  Created by Romain Bousquet on 3/6/2023.
//

import UIKit

final class ProfileCell: UITableViewCell {
    private let roundedView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemCyan
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
    }
    
    func configure(_ viewModel: ListScene.ProfilesViewModel.ProfileViewModel) {
        roundedView.backgroundColor = viewModel.color
    }
}

private extension ProfileCell {
    func setup() {
        roundedView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(roundedView)
        NSLayoutConstraint.activate([
            roundedView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            roundedView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: roundedView.bottomAnchor, constant: 15),
            contentView.rightAnchor.constraint(equalTo: roundedView.rightAnchor, constant: 15)
        ])
        
        roundedView.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: roundedView.leftAnchor, constant: 15).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: roundedView.bottomAnchor, constant: -15).isActive = true
        profileImageView.topAnchor.constraint(equalTo: roundedView.topAnchor, constant: 15).isActive = true
    }
}
