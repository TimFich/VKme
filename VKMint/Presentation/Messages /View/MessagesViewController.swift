//
//  SnapKitMessagesViewController.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 28.04.2022.
//

import UIKit
import SnapKit

class MessagesViewController: UIViewController {
    
    //MARK: - State enum
    private enum State {
        case conversation
        case chat
    }
    
    //MARK: - UI
    private let tableView = UITableView()
    private let segmentControl = UISegmentedControl(items: ["Conversations", "Chats"])
    private let kCellIdentifier = "cell"
    
    //MARK: - Private properties
    private var model = MessagesModel()
    private var state = State.conversation {
        didSet {
            tableView.reloadData()
        }
    }
    
    //MARK: - View life cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MessagesTableViewCell.self, forCellReuseIdentifier: kCellIdentifier)
        model.delegate = self
        configureSegment()
    }
    
    //MARK: - Configure UI
    func configureSegment() {
        segmentControl.addTarget(self, action: #selector(segmentChangedState(_:)), for: .valueChanged)
        segmentControl.selectedSegmentIndex = 0
        view.addSubview(segmentControl)
        segmentControl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(20)
        }
        configureTable()
    }
    
    func configureTable() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(0)
            make.top.equalTo(segmentControl.snp.bottom).offset(10)
            make.right.bottom.equalToSuperview().inset(0)
        }
    }
    
    //MARK: - Actions
    @objc
    func segmentChangedState(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            state = .conversation
        } else {
            state = .chat
        }
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension MessagesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch state {
        case .conversation:
            return model.convCellData.count
        case .chat:
            return model.chatsCellData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier) as? MessagesTableViewCell else { return UITableViewCell() }
        switch state {
        case .chat:
            cell.configure(cellData: model.chatsCellData[indexPath.row])
        case .conversation:
            cell.configure(cellData: model.convCellData[indexPath.row])
        }
        return cell
    }
}

//MARK: - MessageModelDelegate
extension MessagesViewController: MessageModelDelegate {
    
    func didLoadConversations() {
        if state == .conversation {
            tableView.reloadData()
        }
    }
    
    func didLoadChats() {
        if state == .chat {
            tableView.reloadData()
        }
    }
}
