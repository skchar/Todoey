//
//  ViewController.swift
//  Todoey
//
//  Created by Char Shu Kai on 13/2/2020.
//  Copyright © 2020 Char Shu Kai. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {
    
    var todoItems: Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory: Category?{
        didSet{
            loadItems()
        }
    }
    
  

    override func viewDidLoad() {
        super.viewDidLoad()
        
     }
    

    //MARK: TableView DataSouce Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row]{
           
            cell.textLabel?.text = item.title
            
            cell.accessoryType = item.done  ? .checkmark : .none
        }else{
            cell.textLabel?.text = "No Items Added"
        }
        
        return cell

    }
    
    
    
    //MARK: TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        todoItems[indexPath.row].done = !todoItems[indexPath.row].done
//
//        saveItems()
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

    //MARK: Add New Items (addButtonPressed)
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicked the Add item button
           
            if let currentCategory = self.selectedCategory{
                do{
                try self.realm.write {
                    let newItem = Item()
                    newItem.title = textField.text!
                    currentCategory.items.append(newItem)
                  }
                }catch{
                        print("Error saving the new items, \(error)")
                    }
                }
            
                self.tableView.reloadData()
            
            }
        
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
   //MarK: - load the items method
    func loadItems(){
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
    }
}

