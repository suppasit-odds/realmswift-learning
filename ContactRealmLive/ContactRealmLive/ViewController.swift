//
//  ViewController.swift
//  ContactRealmLive
//
//  Created by Suppasit beer on 28/12/2564 BE.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let mike = ContactItem(name: "mike", telephone: "1232333333")
    var people = try! Realm().objects(ContactItem.self).sorted(byKeyPath: "name", ascending: true)
    var realm: Realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.title = "Contact List"
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
        let nextView = self.storyboard?.instantiateViewController(withIdentifier: "SaveViewController") as! SaveViewController
        nextView.delegateFunction = {
            self.tableView.reloadData()
        }
        navigationController?.pushViewController(nextView, animated: false)
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
