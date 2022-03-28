//
//  AuthViewController.swift
//  VKMint
//
//  Created by Ильдар Арсламбеков on 20.01.2022.
//

import UIKit
import SwiftyVK

class AuthViewController: UIViewController {
    
    //MARK: - Properties
    let authModel = AuthModel()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logInButtonPressed(_ sender: Any) {
        authModel.authorize(completion: { [weak self] in
            DispatchQueue.main.async {
                self?.performSegue(withIdentifier: "enter", sender: nil)
            }
        }, onError: {
        })
        segueIfAuthorised()
    }
    
    //MARK: - Private functions
    private func segueIfAuthorised() {
        if VKDelegate.isAuthorised() {
            self.performSegue(withIdentifier: "enter", sender: nil)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
