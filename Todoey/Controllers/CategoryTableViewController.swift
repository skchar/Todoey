//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Char Shu Kai on 14/2/2020.
//  Copyright © 2020 Char Shu Kai. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categoryArray: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

      loadCategories()
    }
    
   

    // MARK: - Table view data source

   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
         return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No Category Added"
        
        return cell
        
    }

    // MARK: - Table view data delegate
  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
        }
        
    }
    // MARK: - Save Categories
    
    func save(category:Category){
        do{
            try realm.write {
                realm.add(category)
            }
        }catch{
            print("Error saving category \(error)")
        }
        
        tableView.reloadData()
    }
    
    // MARK: - load Categories
    
    func loadCategories(){
        
        categoryArray = realm.objects(Category.self)
        
        tableView.reloadData()
        
    }
    
    // MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
        
            let newCategory = Category()
            newCategory.name = textField.text!
            
            self.save(category: newCategory)
            
       
        
    }
        
    alert.addAction(action)
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new category"
        }
        
        present(alert, animated: true, completion: nil)
 }
}
