//
//  SnapKitMessagesViewController.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 28.04.2022.
//

import UIKit
import SnapKit

protocol MessagesViewInputProtocol {
    func dataFetched(data: [TableViewCellData])
}

protocol MessagesViewOutputProtocol {
    func viewDidLoad()
    func nextButtonPressed(offset: Int)
}

class MessagesViewController: UIViewController {
    
    var data: [TableViewCellData] = []
    var presenter: MessagesPresenter!
    var offset = 0
    var unreadCount = 0
    var unreadRows: [Int] = []
    
    //MARK: - UI
    private let tableView = UITableView()
    private let kCellIdentifier = "cell"
        
    //MARK: - View life cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MessagesTableViewCell.self, forCellReuseIdentifier: kCellIdentifier)
        presenter.viewDidLoad()
        configureTable()
    }
    
    func updateConversation(updatedData: [TableViewCellData], unreadMessagesCount: Int) {
        
    }
    
    //MARK: - Configure UI
    func configureTable() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(0)
            make.top.equalToSuperview().offset(0)
            make.right.bottom.equalToSuperview().inset(0)
        }
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension MessagesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier) as? MessagesTableViewCell else { return UITableViewCell() }
        cell.configure(cellData: data[indexPath.row])
        return cell
    }
}

extension MessagesViewController: MessagesNextButtonCellOutputProtocol {
    func nextPressed() {
        offset += 200
        presenter.nextButtonPressed(offset: offset)
    }
}
    

extension MessagesViewController: MessagesViewInputProtocol {
    func dataFetched(data: [TableViewCellData]) {
        self.data.append(contentsOf: data)
        tableView.reloadData()
    }
}
