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
    var itemArray = [Item]()
    let defaults = UserDefaults.standard
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Uni"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Personal"
        itemArray.append(newItem2)

        let newItem3 = Item()
        newItem3.title = "Work"
        itemArray.append(newItem3)

        
        
        if let items = defaults.array(forKey:"ToDueListArray") as? [Item]{
            itemArray = items
        }
    }

    //MARK - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDueItemCell", for: indexPath)
        let item =  itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Ternary operator
        cell.accessoryType = item.done ? .checkmark : .none
 
        return cell
    }
   
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK - Add new items button
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add a new item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the Add Item button
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            self.tableView.reloadData()
        }
       
        alert.addTextField { (alertTF) in
            alertTF.placeholder = "Type an new Item"
            textField = alertTF
        }
        alert.addAction(action)
        self.present(alert,animated: true, completion: nil)
    
    }
    

}
