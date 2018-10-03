//
//  ViewController.swift
//  Todue
//
//  Created by David Torres on 25.09.18.
//  Copyright © 2018 David Torres. All rights reserved.
//

import UIKit
import RealmSwift


class TodueListViewController: UITableViewController {
    //Variables
    var toDueItems: Results<Item>?
    
    let realm = try! Realm()
    
    var selectedCategory : Category?{
        didSet{
            loadItems()
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }

    //MARK - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDueItems?.count ?? 1
    }
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDueItemCell", for: indexPath)
        if let item =  toDueItems?[indexPath.row]{
            cell.textLabel?.text = item.title
            
            //Ternary operator
            cell.accessoryType = item.done ? .checkmark : .none
        }else{
            cell.textLabel?.text = "No items added"
        }
        
        
 
        return cell
    }
   
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = toDueItems?[indexPath.row]{
            do{
                try realm.write {
                    item.done = !item.done
                }
            }catch{
                print("Error updating,\(error)")
            }
        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    //MARK - Add new items button
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add a new item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the Add Item button
            
            if let currentCategory = self.selectedCategory{
                do{
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        currentCategory.items.append(newItem)
                        newItem.dateCreated = Date()
                    }
                }catch{
                    print("error saving item!, \(error)")
                }
            }
            self.tableView.reloadData()
        }
       
        alert.addTextField { (alertTF) in
            alertTF.placeholder = "Type an new Item"
            textField = alertTF
        }
        alert.addAction(action)
        self.present(alert,animated: true, completion: nil)
    
    }
    
   
    
    
    //Reads from the DB 
    func loadItems(){
       toDueItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
    
}
// MARK :- Search Bar Methods COREDATA
//extension TodueListViewController : UISearchBarDelegate{
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//      let predicate = NSPredicate (format: "title CONTAINS[cd] %@", searchBar.text!)
//
//        let sortDescriptr = NSSortDescriptor(key: "title", ascending: true)
//
//        request.sortDescriptors = [sortDescriptr]
//
//        loadItems(with: request, predicate: predicate)
//    }
//
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0{
//            loadItems()
//
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//
//        }
//    }

// MARK :- Search Bar Methods REALM
extension TodueListViewController : UISearchBarDelegate{

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        toDueItems = toDueItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: false)
        tableView.reloadData()
    }


    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

        }
    }

}

