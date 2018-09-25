//
//  ViewController.swift
//  Todue
//
//  Created by David Torres on 25.09.18.
//  Copyright © 2018 David Torres. All rights reserved.
//

import UIKit

class TodueListViewController: UITableViewController {
    //Variables
    let itemArray = ["Uni", "Personal", "Work"]
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDueItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
   
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(indexPath.row)
        if  tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    

}

