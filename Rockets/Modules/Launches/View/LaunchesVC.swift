//
//  LaunchesVC.swift
//  Rockets
//
//  Created by Dmitry Shlepkin on 1/19/23.
//

import UIKit

final class LaunchesVC: UIViewController {
    
    var presenter: LaunchesPresenterProtocol!
    
    private let loadingView = LoadingView()
    private let emptyView = EmptyView()
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadingView.playAnimation()
        presenter.setTitle()
        presenter.getLaunches()
    }
        
}

// MARK: - UITableViewDataSource
extension LaunchesVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.launches.count
    }
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
            
}

extension LaunchesVC: UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: LaunchTableViewCell.identifier) as? LaunchTableViewCell else {
            return UITableViewCell()
        }
        let launch = presenter.launches[indexPath.row]
        cell.configure(
            title: launch.name,
            date: launch.dateFormatted(),
            status: launch.success
        )
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
}


// MARK: - LaunchesViewProtocol
extension LaunchesVC: LaunchesViewProtocol {

    func setNavigationTitle(with rocketName: String) {
        navigationItem.title = rocketName
    }
    
    func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showTable() {
        DispatchQueue.main.async {
            self.loadingView.removeFromSuperview()
            self.setupTableView()
            self.reloadTable()
        }
    }
    
    func showEmpty(_ title: String, _ description: String) {
        DispatchQueue.main.async {
            self.loadingView.removeFromSuperview()
            self.setupEmptyView(title: title, description: description)
        }
    }
    
}

// MARK: - Setup
private extension LaunchesVC {
    
    func setup() {
        setupNavigation()
        setupLoadingView()
    }
    
    func setupNavigation() {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func setupLoadingView() {
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
        tableView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        tableView.register(LaunchTableViewCell.self, forCellReuseIdentifier: LaunchTableViewCell.identifier)
    }
    
    func setupEmptyView(title: String, description: String) {
        view.addSubview(emptyView)
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyView.topAnchor.constraint(equalTo: view.topAnchor),
            emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        emptyView.configure(title: title, description: description)
    }
    
}
