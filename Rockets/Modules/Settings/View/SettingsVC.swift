//
//  SettingsVC.swift
//  Rockets
//
//  Created by Dmitry Shlepkin on 1/13/23.
//

import UIKit

final class SettingsVC: UIViewController {
    
    private let headerView = UIView()
    private let titleLabel = UILabel()
    private let closeButton = UIButton()
    private let tableView = UITableView()
    private var settings = [Setting]()
    var presenter: SettingsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter?.getSettings()
    }
    
    @objc private func buttonHandler() {
        presenter?.close()
        self.dismiss(animated: true)
    }
    
}

// MARK: - Setup
private extension SettingsVC {
    
    func setup () {
        view.backgroundColor = .black
        setupHeaderView()
        setupTitleLabel()
        setupCloseButton()
        setupNavigation()
        setupTableView()
    }
    
    func setupHeaderView() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.heightAnchor.constraint(equalToConstant: 56),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupTitleLabel() {
        headerView.addSubview(titleLabel)
        titleLabel.text = "Settings"
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
    }
    
    func setupCloseButton() {
        headerView.addSubview(closeButton)
        closeButton.setTitle("Close", for: .normal)
        closeButton.setTitleColor(UIColor(hex: "#666666"), for: .normal)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        closeButton.addTarget(self, action: #selector(buttonHandler), for: .touchUpInside)
    }
    
    func setupNavigation() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .black
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInset = UIEdgeInsets(top: 56, left: 0, bottom: 0, right: 0)
        tableView.allowsSelection = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
    }

}

// MARK: - UITableViewDataSource
extension SettingsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}

// MARK: - UITableViewDelegate
extension SettingsVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(
            with: settings[indexPath.row],
            settingChanged: self.presenter.change
        )
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
}

// MARK: - SettingsViewProtocol Conformance
extension SettingsVC: SettingsViewProtocol {
    
    func showSettingsTable(settings: [Setting]) {
        self.settings = settings
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}
