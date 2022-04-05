//
//  MessagesViewController.swift
//  VKMelissa
//
//  Created by Ильдар Арсланов on 23.01.2025.
//

import UIKit
import SwiftyVK

class MessagesViewController: UIViewController, NSUserActivityDelegate, UITableViewDelegate {
    
    private enum State {
        case conversation
        case chat
    }
    
    //MARK: - Properties
    var model = MessagesModel()
    
    private var state = State.conversation {
        didSet {
            DispatchQueue.main.async {
                self.messagesTable.reloadData()
            }
        }
    }
    
    //MARK: - IBOutlets
    @IBOutlet weak var messagesTable: UITableView!
    
    @IBAction func segmentChangedState(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            state = .conversation
        } else {
            state = .chat
        }
    }
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
        messagesTable.delegate = self
        messagesTable.dataSource = self
        messagesTable.register(UINib.init(nibName: "MessagesTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
}

//MARK: - Table View Data Source
extension MessagesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch state {
        case .conversation:
            return model.convCellData.count
        case .chat:
            return model.chatsCellData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = messagesTable.dequeueReusableCell(withIdentifier: "cell") as? MessagesTableViewCell else { return UITableViewCell() }
        switch state {
        case .chat:
            cell.configure(cellData: model.chatsCellData[indexPath.row])
        case .conversation:
            cell.configure(cellData: model.convCellData[indexPath.row])
        }
        return cell
        
    }
}

extension MessagesViewController: MessageModelDelegate {
    func didLoadConversations() {
        if state == .conversation {
            messagesTable.reloadData()
        }
    }
    
    func didLoadChats() {
        if state == .chat {
            messagesTable.reloadData()
        }
    }
}
