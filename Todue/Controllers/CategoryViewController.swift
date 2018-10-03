//
//  CategoryViewController.swift
//  Todue
//
//  Created by David Torres on 27.09.18.
//  Copyright © 2018 David Torres. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {

    var categoryArray : Results<Category>?
    
    let realm = try! Realm()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readDB()

    }
     //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
    
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "no categories added yet"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    //Will be call BEFORE performSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodueListViewController
        
        if  let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
        }
    }
    
    
     //MARK: - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Create Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Done", style: .default) { (action) in
            //what will happen with the alert
           let newCategory = Category()
           newCategory.name = textField.text!
            
            self.save(category: newCategory)
        }
        
        alert.addTextField { (addTF) in
            addTF.placeholder = "Create a new Category"
            textField = addTF
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

    
    
     //MARK: - Data Manipulation Methods
    
    func save(category: Category){
        do{
            try realm.write {
                realm.add(category)
            }
        }catch{
            print("error in commiting!, \(error)")
        }
        self.tableView.reloadData()
    }
    
    
    func readDB(){
        categoryArray = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    
}
