//
//  SettingsTableViewController.swift
//  ChatChat
//
//  Created by Angela Zhang on 9/10/19.
//  Copyright © 2019 qinyuanzhang.com. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }


    // MARK: - Logout Button
    @IBAction func LogOutButtonPressed(_ sender: Any) {
        
        FUser.logOutCurrentUser { (isSucess) in
            
            if(isSucess){
                //bring the user back to the login view
                self.showLoginView()
                
            }
        }
    }
    func showLoginView (){
        //create an instance of login view
        let mainView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login") 
        
        self.present(mainView, animated: true, completion: nil)
    }
    
}
