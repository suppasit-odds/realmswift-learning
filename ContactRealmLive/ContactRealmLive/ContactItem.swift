//
//  ContactItem.swift
//  ContactRealmLive
//
//  Created by Suppasit beer on 28/12/2564 BE.
//

import Foundation
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

class ContactRealmWrapper {
    static var shared = ContactRealmWrapper()
    var realm: Realm
    
    init() {
        self.realm = try! Realm()
    }
    
    func getRealmObject() -> Results<ContactItem> {
        return try! Realm().objects(ContactItem.self).sorted(byKeyPath: "name", ascending: true)
    }
}
