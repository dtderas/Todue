//
//  CategoryViewController.swift
//  Todue
//
//  Created by David Torres on 27.09.18.
//  Copyright © 2018 David Torres. All rights reserved.
//

import UIKit
import CoreData


class CategoryViewController: UITableViewController {

    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readDB()

    }
     //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
    
        cell.textLabel?.text = categoryArray[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    //Will be call BEFORE performSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodueListViewController
        
        if  let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
    
     //MARK: - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Create Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Done", style: .default) { (action) in
            //what will happen with the alert
           let newCategory = Category(context: self.context)
           newCategory.name = textField.text
            
            self.categoryArray.append(newCategory)
            
            self.commitChanges()
        }
        
        alert.addTextField { (addTF) in
            addTF.placeholder = "Create a new Category"
            textField = addTF
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

    
    
     //MARK: - Data Manipulation Methods
    
    func commitChanges(){
        do{
       try context.save()
        }catch{
            print("error in commiting!, \(error)")
        }
        self.tableView.reloadData()
    }
    
    
    func readDB(){
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        do{
            categoryArray = try context.fetch(request)
        }catch{
            print("error in reading!, \(error)")
        }
        tableView.reloadData()
    }
    
    
}
