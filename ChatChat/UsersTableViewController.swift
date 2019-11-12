//
//  UsersTableViewController.swift
//  ChatChat
//
//  Created by Angela Zhang on 11/11/19.
//  Copyright © 2019 qinyuanzhang.com. All rights reserved.
//

import UIKit
import Firebase
import ProgressHUD

class UsersTableViewController: UITableViewController,UISearchResultsUpdating {
    

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var filterSegmentedControl: UISegmentedControl!
    
    
    
    var allUsers: [FUser] = []
    var filteredUser: [FUser] = []
    var allUsersGroup = NSDictionary() as! [String : [FUser]]
    var sectionTitleLists: [String] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return 0
    }
    
    func loadUsers(filter: String){
        ProgressHUD.show()
        
        var query: Query!
        
        switch filter{
        case kCITY:
            query = reference(.User).whereField(kCITY, isEqualTo: FUser.currentUser()!.city).order(by: kFIRSTNAME,descending: false)
        case kCOUNTRY:
            query = reference(.User).whereField(kCOUNTRY, isEqualTo: FUser.currentUser()!.country).order(by: kFIRSTNAME,descending: false)
        default:
            query = reference(.User).order(by: kFIRSTNAME, descending: false)
        }
        
        
        query.getDocuments { (snapshot, error) in
            self.allUsers = []
            self.sectionTitleLists = []
            self.allUsersGroup = [:]
            
            if error != nil{
                print(error!.localizedDescription)
                ProgressHUD.dismiss()
                self.tableView.reloadData()
                return
            }
            guard let snapshot = snapshot else{
                ProgressHUD.dismiss(); return
            }
            
            if !snapshot.isEmpty{
                for userDictionary in snapshot.documents{
                    let userDictionary = userDictionary.data() as NSDictionary
                    let fUser = FUser(_dictionary: userDictionary)
                    
                    if fUser.objectId != FUser.currentId(){
                        self.allUsers.append(fUser)
                    }
                    
                }
            }
            
            
            
        }
        
        
        
    }

    //MARK Search controller functions
    
    func filterContentForSearchText(searchText: String, scope: String = "All"){
        filteredUser = allUsers.filter({ (user) -> Bool in
            return user.firstname.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    
    

}
