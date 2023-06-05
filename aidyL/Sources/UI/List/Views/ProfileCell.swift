//
//  ProfileCell.swift
//  aidyL
//
//  Created by Romain Bousquet on 3/6/2023.
//

import UIKit
import Combine

final class ProfileCell: UITableViewCell {
    private let roundedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .title
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .body
        return label
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemCyan
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let blackGradient = CAGradientLayer.makeBlackGradient(
      startPoint: CGPoint(x: 0, y: 1),
      endPoint: CGPoint(x: 0, y: 0)
    )

    
    private var cancellables = Set<AnyCancellable>()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        blackGradient.frame = roundedView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
    }

    func configure(_ viewModel: ListScene.ProfilesViewModel.ProfileViewModel) {
        roundedView.backgroundColor = viewModel.color
        nameLabel.text = viewModel.name
        emailLabel.text = viewModel.email
        profileImageView.downloadImage(publisher: viewModel.imagePublisher).store(in: &cancellables)
    }
}

private extension ProfileCell {
    func setup() {
        selectionStyle = .none

        setupRoundedView()
        setupImageView()
        setupLabels()
        setupGradient()
    }
    
    func setupRoundedView() {
        contentView.addSubview(roundedView)
        NSLayoutConstraint.activate([
            roundedView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            roundedView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: roundedView.bottomAnchor),
            contentView.rightAnchor.constraint(equalTo: roundedView.rightAnchor)
        ])
    }
    
    func setupImageView() {
        roundedView.addSubview(profileImageView)
        NSLayoutConstraint.activate([
            profileImageView.heightAnchor.constraint(equalToConstant: 75),
            profileImageView.widthAnchor.constraint(equalToConstant: 75),
            profileImageView.leftAnchor.constraint(equalTo: roundedView.leftAnchor, constant: 15),
            profileImageView.bottomAnchor.constraint(equalTo: roundedView.bottomAnchor, constant: -15),
            profileImageView.topAnchor.constraint(equalTo: roundedView.topAnchor, constant: 15)
        ])
    }
    
    func setupLabels() {
        roundedView.addSubview(labelStackView)
        let bottomConstraint = labelStackView.bottomAnchor.constraint(
            greaterThanOrEqualTo: roundedView.bottomAnchor,
            constant: -15
        )
        bottomConstraint.priority = UILayoutPriority(750)
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: labelStackView.topAnchor),
            labelStackView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 15),
            bottomConstraint,
            roundedView.rightAnchor.constraint(equalTo: labelStackView.rightAnchor, constant: 15)
        ])
        labelStackView.addArrangedSubview(nameLabel)
        labelStackView.addArrangedSubview(emailLabel)
    }
    
    func setupGradient() {
        guard blackGradient.superlayer == nil else { return }
        roundedView.layer.insertSublayer(blackGradient, at: 0)
        blackGradient.frame = roundedView.bounds
    }
}

private extension CAGradientLayer {
    static func makeBlackGradient(startPoint: CGPoint, endPoint: CGPoint) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        let startColor = UIColor.black.withAlphaComponent(0.2)
        gradient.colors = [startColor.cgColor, UIColor.clear.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        return gradient
    }
}
