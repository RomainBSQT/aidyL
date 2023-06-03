//
//  ListViewController.swift
//  aidyL
//
//  Created by Romain Bousquet on 3/6/2023.
//

import UIKit

protocol ListDisplayLogic: AnyObject {
    func initial(_ viewModel: ListScene.InitialViewModel)
    func profiles(_ viewModel: ListScene.ProfilesViewModel)
}

final class ListViewController: UIViewController {
    // MARK: - UI elements
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.registerIdentifiable(ProfileCell.self)
        return tableView
    }()
    
    private lazy var diffableDatasource: UITableViewDiffableDataSource<Int, ListScene.ProfilesViewModel.ProfileViewModel> = {
        let datasource = UITableViewDiffableDataSource<Int, ListScene.ProfilesViewModel.ProfileViewModel>(tableView: tableView) { tableView, indexPath, viewModel in
            let cell: ProfileCell = tableView.dequeueReusable(at: indexPath)
            cell.configure(viewModel)
            return cell
        }
        return datasource
    }()
    
    // MARK: - Injected
    private let interactor: ListInteractorLogic
    private let router: ListRoutingLogic
    
    // MARK: - Lifecycle
    init(worker: RandomUserBusinessLogic) {
        let presenter = ListPresenter()
        let router = ListRouter()
        self.router = router
        self.interactor = ListInteractor(presenter: presenter, worker: worker)
        super.init(nibName: nil, bundle: nil)
        presenter.display = self
        router.source = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        interactor.start()
        interactor.loadProfiles()
    }
}

extension ListViewController: ListDisplayLogic {
    func initial(_ viewModel: ListScene.InitialViewModel) {
        navigationItem.title = viewModel.title
    }

    func profiles(_ viewModel: ListScene.ProfilesViewModel) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, ListScene.ProfilesViewModel.ProfileViewModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.profiles, toSection: 0)
        diffableDatasource.apply(snapshot, animatingDifferences: false)
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

private extension ListViewController {
    func configure() {
        view.backgroundColor = .white
        view.embed(tableView, inset: 15)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.dataSource = diffableDatasource
        tableView.delegate = self
        tableView.clipsToBounds = true
    }
}
