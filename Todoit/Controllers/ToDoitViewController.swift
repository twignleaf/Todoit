//
//  ViewController.swift
//  Todoit
//
//  Created by William on 19/6/2018.
//  Copyright © 2018 William Yuan. All rights reserved.
//

import UIKit

class ToDoitViewController: UITableViewController {

    var itemArray = [Item]()
    
    // Using UserDefaults to persist data
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let newItem = Item()
        newItem.title = "1"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "2"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "3"
        itemArray.append(newItem3)
        
        // Retrieving data, from itemArray by using UserDefaults key TodoListArray
//        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
//            itemArray = items
//        }
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
            itemArray = items
        }
    }

    //MARK - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("cellForRowAtIndexPath Called")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        // Ternery Operator ==>
        // value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        // Using done property to display checkmark on individual itemArray
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    
    //MARK - Tableview Delegate Methods
    
    // Detecting rows in TableView
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Printing selected items in itemArray by indexPath.row
//        print(itemArray[indexPath.row])
        
        // Setting the done property opposite of what is is right now, Ternary Operator
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
        
        //Ternary opeartor ==>
        // value = condition ? valueIfTrue : valueIfFalse
        
        // If statement to check if tableView is already checkmarked, if so, rm it
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else {
//
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }

        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

    //MARK - Add New Items
 
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDoit Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // What will happen once the user clicks the Add Item button on the UIAlert
            
            let newItem = Item()
            newItem.title = textField.text!
            
            // Use self when in closure
            self.itemArray.append(newItem)
            
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

