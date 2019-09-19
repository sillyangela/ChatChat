//
//  UsersUITableViewController.swift
//  ChatChat
//
//  Created by Angela Zhang on 9/10/19.
//  Copyright © 2019 qinyuanzhang.com. All rights reserved.
//

import UIKit

class UsersUITableViewController: UITableViewController {

    
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var filterSGC: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
}
