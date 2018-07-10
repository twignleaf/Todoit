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
    
    // encoding and decoding filepath, converted array Items into plist file
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    // Using UserDefaults to persist data [use only for small peices of data with limited sets of data types, it is very inefficient as it has to load up the entire plist before reading the properties you want]  - UserDefaults cannot take any custom types or objects
//    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath!)
        
        loadItems()

        // 1.
//        let newItem = Item()
//        newItem.title = "1"
//        itemArray.append(newItem)
//
//        let newItem2 = Item()
//        newItem2.title = "2"
//        itemArray.append(newItem2)
//
//        let newItem3 = Item()
//        newItem3.title = "3"
//        itemArray.append(newItem3)
        
        
        // 1. Retrieving data, from itemArray by using UserDefaults key TodoListArray
//        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
//            itemArray = items
//        }
        
//        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
//            itemArray = items
//        }
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
        
        // 2.
        cell.accessoryType = item.done ? .checkmark : .none
        
        // Ternery Operator ==>
        // value = condition ? valueIfTrue : valueIfFalse
        
        // 1. Using done property to display checkmark on individual itemArray
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
        
        // 1.
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
        
        //Ternary opeartor ==>
        // value = condition ? valueIfTrue : valueIfFalse
        
        // 1. If statement to check if tableView is already checkmarked, if so, rm it
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else {
//
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }

        // 2. Setting the done property opposite of what is is right now, Ternary Operator
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
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
            
            self.saveItems()
            
            // 1. for using UserDefaults
//            self.defaults.set(self.itemArray, forKey: "TodoListArray")

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
    
    //MARK - Model Manipulation Methods
    
    func saveItems() {
    
        // Encoding and assigning data
        let encoder = PropertyListEncoder()
    
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
        
        // Reload tableView to show data
        self.tableView.reloadData()
    }
    
    // Decoding and retrieving data
    func loadItems() {
        
        // try turns result into optional
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding item array, \(error)")
            }
        }
    }
}

