//
//  SnapKitMessagesViewController.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 28.04.2022.
//

import UIKit
import SnapKit

protocol MessagesViewInputProtocol {
    func dataFetched(data: [MessageTableViewCellData])
    func didStartUpdatingConversations()
    func didEndUpdatingConversations()
    func updateLastMessage(message: LastMessage)
}

protocol MessagesViewOutputProtocol {
    func viewDidLoad()
    func nextButtonPressed(offset: Int)
    func wantsToOpenChat(id: Int)
}

class MessagesViewController: UIViewController {
    
    //MARK: - Properties
    var data: [MessageTableViewCellData] = []
    var peerIdToIndexDict: [Int: Int] = [:]
    var presenter: MessagesPresenter!
    var offset = 0
    var unreadCount = 0
    var unreadRows: [Int] = []
    
    //MARK: - UI
    private let tableView = UITableView()
    let activityIndicator = UIActivityIndicatorView(style: .large)
    let headerView = UIView()
    private let kCellIdentifier = "cell"
        
    //MARK: - View life cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chats"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MessagesTableViewCell.self, forCellReuseIdentifier: kCellIdentifier)
        configureTable()
        presenter.viewDidLoad()
    }
    
    //MARK: - Configure UI
    private func configureTable() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(0)
            make.top.equalToSuperview().offset(0)
            make.right.bottom.equalToSuperview().inset(0)
        }
    }
    
    private func makePeerIdDict() {
        for (index, element) in data.enumerated() {
            peerIdToIndexDict[element.peerId] = index
        }
    }
    
    private func setUpUIForLoader() {
        activityIndicator.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerView.addSubview(activityIndicator)
        setUpUIForLoader()
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.wantsToOpenChat(id: data[indexPath.row].peerId)
    }
}    

//MARK: - MessagesViewInputProtocol
extension MessagesViewController: MessagesViewInputProtocol {
    
    func didStartUpdatingConversations() {
        activityIndicator.startAnimating()
    }
    
    func didEndUpdatingConversations() {
        activityIndicator.stopAnimating()
    }
    
    func dataFetched(data: [MessageTableViewCellData]) {
        self.data = data
        makePeerIdDict()
        tableView.reloadData()
    }
    
    func updateLastMessage(message: LastMessage) {
        let index = peerIdToIndexDict[message.peerID]
        guard let index = index else {
            return
        }
        data[index].lastMessage = message.text
        data[index].unreadCount += 1
        tableView.reloadData()
    }
}
