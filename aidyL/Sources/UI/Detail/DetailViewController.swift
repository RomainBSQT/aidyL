//
//  DetailViewController.swift
//  aidyL
//
//  Created by Romain Bousquet on 3/6/2023.
//

import UIKit
import Combine
import MapKit

protocol DetailDisplayLogic: AnyObject {
    func initial(_ viewModel: DetailScene.InitialViewModel)
    func mapSnapshot(_ viewModel: DetailScene.MapSnapshotViewModel)
}

final class DetailViewController: UIViewController {
    private enum LayoutConstant {
        static let margin: CGFloat = 15
        static let imageSize: CGFloat = 125
        static let mapSnapshotSize: CGFloat = 100
    }
    
    // MARK: - UI Elements
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let masterStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 15
        return stackView
    }()
    
    // MARK: - Header
    private let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private let headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private let imageContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: LayoutConstant.imageSize).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: LayoutConstant.imageSize).isActive = true
        imageView.backgroundColor = .systemGray6.withAlphaComponent(0.3)
        imageView.layer.cornerRadius = 30
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .largeTitleBold
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .body
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let nationalityAndGenderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 35)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Location
    private let locationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 15
        return stackView
    }()
    
    private let addressStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let addressDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .title
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .body
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let locationSnapshotImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: LayoutConstant.mapSnapshotSize).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: LayoutConstant.mapSnapshotSize).isActive = true
        imageView.backgroundColor = .systemGray6.withAlphaComponent(0.3)
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: - Phones
    private let phonesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let phoneDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .title
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .body
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let cellLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .body
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Dates
    private let datesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let datesDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .title
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let dOBLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .body
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let registeredDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .body
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Injected
    private let interactor: DetailInteractorLogic
    
    // MARK: - Lifecycle
    init(profile: ProfileConfiguration) {
        let presenter = DetailPresenter()
        self.interactor = DetailInteractor(profile: profile, presenter: presenter)
        super.init(nibName: nil, bundle: nil)
        presenter.display = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        interactor.start()
    }
}

extension DetailViewController: DetailDisplayLogic {
    func initial(_ viewModel: DetailScene.InitialViewModel) {
        title = viewModel.title
        view.backgroundColor = viewModel.color
        imageView.downloadImage(publisher: viewModel.imagePublisher).store(in: &cancellables)
        nameLabel.text = viewModel.name
        nationalityAndGenderLabel.text = viewModel.nationalityAndGender
        emailLabel.text = viewModel.email
        
        addressDescriptionLabel.text = viewModel.addressDescription
        addressLabel.text = viewModel.address
        
        phoneDescriptionLabel.text = viewModel.phoneDescription
        phoneLabel.text = viewModel.phone
        cellLabel.text = viewModel.cell
        
        datesDescriptionLabel.text = viewModel.datesDescription
        dOBLabel.text = viewModel.dOB
        registeredDateLabel.text = viewModel.registeredDate
    }
    
    func mapSnapshot(_ viewModel: DetailScene.MapSnapshotViewModel) {
        locationSnapshotImageView.image = viewModel.image
    }
}

private extension DetailViewController {
    func setup() {
        setupNavigationBar()
        setupScrollView()
        setupHeader()
        setupLocation()
        setupPhones()
        setupDates()
        masterStackView.addArrangedSubview(UIView())
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.largeTitleBold
        ]
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.titleMedium
        ]
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(masterStackView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstant.margin),
            view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: LayoutConstant.margin),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            masterStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            masterStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            masterStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            masterStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            masterStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }

    func setupHeader() {
        headerView.addSubview(headerStackView)
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: headerView.topAnchor),
            headerStackView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            headerStackView.leftAnchor.constraint(greaterThanOrEqualTo: headerView.leftAnchor),
            headerStackView.leftAnchor.constraint(greaterThanOrEqualTo: headerView.leftAnchor),
            headerStackView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor)
        ])
        masterStackView.addArrangedSubview(headerView)
        
        imageContentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: imageContentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: imageContentView.bottomAnchor),
            imageView.leftAnchor.constraint(greaterThanOrEqualTo: imageContentView.leftAnchor),
            imageView.leftAnchor.constraint(greaterThanOrEqualTo: imageContentView.leftAnchor),
            imageView.centerXAnchor.constraint(equalTo: imageContentView.centerXAnchor)
        ])
        headerStackView.addArrangedSubview(imageContentView)
        headerStackView.addArrangedSubview(nameLabel)
        headerStackView.addArrangedSubview(emailLabel)
        headerStackView.addArrangedSubview(nationalityAndGenderLabel)
    
        masterStackView.addArrangedSubview(.makeSeparator())
    }
    
    func setupLocation() {
        masterStackView.addArrangedSubview(locationStackView)
        addressStackView.addArrangedSubview(addressDescriptionLabel)
        addressStackView.addArrangedSubview(addressLabel)
        locationStackView.addArrangedSubview(addressStackView)
        locationStackView.addArrangedSubview(locationSnapshotImageView)
        
        masterStackView.addArrangedSubview(.makeSeparator())
    }
    
    func setupPhones() {
        masterStackView.addArrangedSubview(phonesStackView)
        phonesStackView.addArrangedSubview(phoneDescriptionLabel)
        phonesStackView.addArrangedSubview(phoneLabel)
        phonesStackView.addArrangedSubview(cellLabel)
        
        masterStackView.addArrangedSubview(.makeSeparator())
    }
    
    func setupDates() {
        masterStackView.addArrangedSubview(datesStackView)
        datesStackView.addArrangedSubview(datesDescriptionLabel)
        datesStackView.addArrangedSubview(dOBLabel)
        datesStackView.addArrangedSubview(registeredDateLabel)
        
        masterStackView.addArrangedSubview(.makeSeparator())
    }
}

private extension UIView {
    static func makeSeparator() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }
}
