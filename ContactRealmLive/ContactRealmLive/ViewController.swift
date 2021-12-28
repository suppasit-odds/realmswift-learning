//
//  ViewController.swift
//  ContactRealmLive
//
//  Created by Suppasit beer on 28/12/2564 BE.
//

import UIKit
import RealmSwift

class ContactItem: Object {
    @objc dynamic var name = ""
    @objc dynamic var telephone = ""
    @objc dynamic var _id: ObjectId = ObjectId.generate()
    
    convenience init(name: String, telephone: String) {
        self.init()
        self.name = name
        self.telephone = telephone
    }
    
    override static func primaryKey() -> String {
        return "_id"
    }
}

enum Gender: String {
    case male, female, none
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let mike = ContactItem(name: "mike", telephone: "1232333333")
    
    var people = try! Realm().objects(ContactItem.self).sorted(byKeyPath: "name", ascending: true)
    var realm: Realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        if realm.isEmpty {
            try! realm.write {
                realm.add(mike)
            }
        }
        let path = realm.configuration.fileURL?.path
        print("Path: \(String(describing: path))")
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Add Contact", message: "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Save", style: .default) { _ in
            let nameField = alertController.textFields![0] as UITextField
            let teleField = alertController.textFields![1] as UITextField
            let newPerson = ContactItem(name: nameField.text!, telephone: teleField.text!)
            try! self.realm.write {
                self.realm.add(newPerson)
                self.tableView.reloadData()
            }
        })
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addTextField { nameField in
            nameField.placeholder = "New Contact Name"
        }
        alertController.addTextField { teleField in
            teleField.placeholder = "+1 (111) 11-1111"
        }
        
        self.present(alertController, animated: true)
    }
   
    
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = people[indexPath.row].name
        cell.detailTextLabel?.text = people[indexPath.row].telephone
        return cell
    }
    
    
}
