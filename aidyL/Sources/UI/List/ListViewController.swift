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
    private enum LayoutConstants {
        static let margin: CGFloat = 15
        static let estimatedCellHeight: CGFloat = 100
    }
    
    enum TableViewSection: Int, CaseIterable {
        case list
        case loadingFooter
    }
    
    // MARK: - UI elements
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.registerIdentifiable(ProfileCell.self)
        tableView.registerIdentifiable(LoaderCell.self)
        return tableView
    }()
    private let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .gray
        return refreshControl
    }()
    
    private var cellViewModels: [ListScene.ProfilesViewModel.ProfileViewModel] = []
    
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
        cellViewModels = viewModel.profiles
        UIView.transition(
            with: tableView,
            duration: 0.35,
            options: .transitionCrossDissolve,
            animations: { self.tableView.reloadData() },
            completion: { _ in self.refreshControl.endRefreshing() }
        )
    }
}

extension ListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        TableViewSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch TableViewSection(rawValue: section) {
        case .list: return cellViewModels.count
        case .loadingFooter: return 1
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch TableViewSection(rawValue: indexPath.section) {
        case .list:
            let cell: ProfileCell = tableView.dequeueReusable(at: indexPath)
            cell.configure(indexPath.row, viewModel: cellViewModels[indexPath.row])
            return cell
        case .loadingFooter:
            return tableView.dequeueReusable(at: indexPath) as LoaderCell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case .loadingFooter = TableViewSection(rawValue: indexPath.section) else { return }
        interactor.loadProfiles()
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
}

private extension ListViewController {
    func configure() {
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.largeTitleBold
        ]
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.titleMedium
        ]
        view.backgroundColor = .white
        view.embed(
            tableView,
            topInset: 0,
            leadingInset: LayoutConstants.margin,
            bottomInset: 0,
            trailingInset: LayoutConstants.margin
        )
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = LayoutConstants.estimatedCellHeight
        tableView.dataSource = self
        tableView.delegate = self
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .primaryActionTriggered)
        tableView.refreshControl = refreshControl
    }
    
    @objc func didPullToRefresh() {
        interactor.freshLoadProfiles()
    }
}
