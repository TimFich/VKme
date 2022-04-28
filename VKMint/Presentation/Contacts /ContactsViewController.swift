//
//  ContactsViewController.swift
//  VKMint
//
//  Created by Тимур Миргалиев on 28.04.2022.
//

import UIKit

class ContactsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let friendsApiInteractor = FriendsApiInteractorImpl()
    
    private var arrayOfFriends: [UserItems] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "ContactsTableViewCell", bundle: nil), forCellReuseIdentifier: "friendsCell")
        friendsApiInteractor.getFriends { result in
            self.arrayOfFriends = result.items
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}

extension ContactsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfFriends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "friendsCell") as? ContactsTableViewCell else { return UITableViewCell()}
        cell.configure(name: arrayOfFriends[indexPath.row].firstName, avatar: UIImage())
        return cell
    }
    
    
}
