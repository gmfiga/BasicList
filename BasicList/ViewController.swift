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
    
    struct Animal {
        var name: String
        var img: UIImage
    }
    
    var animals: [Animal] = []
    
    let dog: Animal = Animal(name: "dog", img: #imageLiteral(resourceName: "download.jpeg"))
    let cat: Animal = Animal(name: "cat", img: #imageLiteral(resourceName: "Cat03.jpg"))
    
    
    let cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        animals.append(dog)
        animals.append(cat)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        
        cell.textLabel?.text = self.animals[indexPath.row].name
        cell.imageView?.image = self.animals[indexPath.row].img
        
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
        alertController.addTextField(configurationHandler: {(imgField) in
            imgField.text = ""
            imgField.placeholder = "Name of the Image:"
            imgField.isSecureTextEntry = false
    })

        alertController.addAction(UIAlertAction(title: "OK" , style: .default, handler: { [weak alertController] (_) in
            let nameField = alertController?.textFields![0]
            let imgField = alertController?.textFields![1]
            var newAnimal: Animal
            if imgField?.text != "" {
                newAnimal = Animal(name: (nameField?.text)!, img: UIImage(named : (imgField?.text)!)!)
            } else {
                newAnimal = Animal(name: (nameField?.text)!, img: UIImage(named: "Who's that Pokemon.png.gallery.jpg" )!)
            }
            self.animals.append(newAnimal)
            self.tableView.reloadData()
        }))
    
    
        present(alertController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
