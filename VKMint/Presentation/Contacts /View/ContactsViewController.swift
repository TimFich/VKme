//
//  ContactsViewController.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 28.04.2022.
//

import UIKit
import SnapKit

protocol ContactsViewOutput {
    func viewDidLoad()
}

protocol ContactsViewInput {
    func needToUpdateContacts(updatedData: [ContactsTableViewCellData])
    
    func startUpdatingUsers()
    
    func endUpdatingUsers()
}

class ContactsViewController: UIViewController {
    
    var presenter: ContactsPresenter!
    lazy var tableView: UITableView = {
        return UITableView(frame: view.frame, style: .insetGrouped)
    }()
    let headerView = UIView()
    private var data: [ContactsTableViewCellData] = []
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ContactsTableViewCell.self, forCellReuseIdentifier: "cell")
        setUpUI()
        presenter.viewDidLoad()
    }
    
    private func setUpUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(0)
            make.top.equalToSuperview().offset(0)
            make.right.bottom.equalToSuperview().inset(0)
        }
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension ContactsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Важные"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if data.isEmpty {
                return 0
            } else {
                return 5
            }
        case 1:
            return data.count - 5
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            headerView.addSubview(activityIndicator)
            activityIndicator.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
            }
            return headerView
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ContactsTableViewCell else {
            return UITableViewCell()
        }
        let section = indexPath.section
        let cellData = section == 0 ? data[indexPath.row] : data[indexPath.row + 5]
        cell.configure(name: cellData.firstName + " " + cellData.lastName, avatar: cellData.photo, lastSeen: cellData.lastSeen, platform: cellData.platform, isOnline: cellData.isOnline)
        return cell
    }
}

//MARK: - ContactsViewInput
extension ContactsViewController: ContactsViewInput {
    func needToUpdateContacts(updatedData: [ContactsTableViewCellData]) {
        data = updatedData
        tableView.reloadData()
    }
    
    func startUpdatingUsers() {
        activityIndicator.startAnimating()
    }
    
    func endUpdatingUsers() {
        activityIndicator.stopAnimating()
    }
}

