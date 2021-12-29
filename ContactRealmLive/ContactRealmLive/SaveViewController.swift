//
//  SaveViewController.swift
//  ContactRealmLive
//
//  Created by Suppasit beer on 28/12/2564 BE.
//

import UIKit

class SaveViewController: UIViewController {
    @IBOutlet weak private var nameTextField: UITextField!
    @IBOutlet weak private var telephoneTextField: UITextField!
    
    var delegateFunction: (() -> Void)?
    
    override func viewDidLoad() {
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        setTextField()
    }
    
    fileprivate func setTextField() {
        nameTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        telephoneTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        print("Text didChange!")
        if nameTextField.text!.isEmpty || telephoneTextField.text!.isEmpty {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let name = nameTextField.text, let telephone = telephoneTextField.text {
            try! ContactRealmWrapper.shared.realm.write {
                ContactRealmWrapper.shared.realm.add(
                    ContactItem(name: name, telephone: telephone)
                )
            }
            if let functionToCall = delegateFunction {
                functionToCall()
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
