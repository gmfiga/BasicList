//
//  ViewController.swift
//  BasicList
//
//  Created by Administrator on 6/25/18.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var myButton: UIButton!
    
    var animals: [String] = ["Dog", "Cat", "Hog"]
    
    let cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        
        cell.textLabel?.text = self.animals[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            animals.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
    
    @IBAction func doAddAnimal(_ sender: Any) {
        let alertController = UIAlertController(title: "New Animal",
                                                message: "Please ad your new animal below:",
                                                preferredStyle: UIAlertControllerStyle.alert)
        alertController.addTextField(configurationHandler: {(nameField) in
            nameField.text = ""
            nameField.placeholder = "Animal Name:"
            nameField.isSecureTextEntry = false
    })
    
        alertController.addAction(UIAlertAction(title: "OK" , style: .default, handler: { [weak alertController] (_) in
            let nameField = alertController?.textFields![0]
            let name = nameField?.text
            self.animals.append(name!)
            self.tableView.reloadData()
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

