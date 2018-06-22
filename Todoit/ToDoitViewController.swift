//
//  ViewController.swift
//  Todoit
//
//  Created by William on 19/6/2018.
//  Copyright © 2018 William Yuan. All rights reserved.
//

import UIKit

class ToDoitViewController: UITableViewController {

    var itemArray = ["1","2","3"]
    
    // Using UserDefaults to persist data
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Retrieving data, setting itemArray to the array in the user defaults
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = items
        }
    }

    //MARK - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //MARK - Tableview Delegate Methods
    
    // Detecting rows in TableView
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Printing selected items in itemArray by indexPath.row
//        print(itemArray[indexPath.row])
        
        // If statement to check if tableView is already checkmarked, if so, rm it
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }

        tableView.deselectRow(at: indexPath, animated: true)
        
    }

    //MARK - Add New Items
 
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDoit Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // What will happen once the user clicks the Add Item button on the UIAlert
            
            // Use self when in closure
            self.itemArray.append(textField.text!)
            print(textField.text!)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            // Reload tableView to show data
            self.tableView.reloadData()
        }
        
            alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            print(alertTextField.text!)
            
            // extenting scope of alertTextField
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}

