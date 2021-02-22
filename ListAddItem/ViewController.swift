//
//  ViewController.swift
//  ListAddItem
//
//  Created by Akdag on 22.02.2021.
//

import UIKit

class ViewController: UITableViewController {
    
    var items = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        let value = defaults.stringArray(forKey: "item")!
        items = value
        
        
        
        view.backgroundColor = .systemPink
        title = "Add New Item"
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(AddNewItem))
        navigationItem.rightBarButtonItem?.tintColor = .green
        
        let editBtn = editButtonItem
        editBtn.tintColor = .green
        navigationItem.leftBarButtonItem = editBtn
        
        load()
        
    }
    @objc func AddNewItem(){
        let ac = UIAlertController(title: "Add New Item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self , weak ac] action in
            guard let item = ac?.textFields?[0].text else {return}
            self?.items.insert(item, at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            self?.tableView.insertRows(at: [indexPath].self, with: .automatic)
            
            
        }))
        present(ac, animated: true, completion: nil)
        save()
    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        tableView.reloadData()
        save()
    }
    
    
   
    
    func save(){
        UserDefaults.standard.set(items , forKey: "item")
    }
    
    func load(){
        if let loadedData : [String] = UserDefaults.standard.stringArray(forKey: "item"){
            items = loadedData
        }
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.backgroundColor = .systemPink
        cell.textLabel?.textColor = .white
        let defaults = UserDefaults.standard
        defaults.set(items, forKey: "item")
        
        return cell
    }
    
}

