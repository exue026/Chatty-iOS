//
//  ProfileEditController.swift
//  chatty
//
//  Created by Ethan Xue on 2017-08-01.
//  Copyright © 2017 xTech. All rights reserved.
//

import UIKit

protocol DataReceiver {
    func getData(data: AnyHashable)
}

class ProfileEditController: UIViewController, DataReceiver, UITextFieldDelegate  {
    
    // MARK: Properties
    
    private let className = String(typeOfClass: ProfileEditController.self)
    private var data: String?
    private var didMakeChanges: Bool = false
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(theme: .purpleblue)
        button.setTitle("SAVE".localized(), for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(saveInfo), for: .touchUpInside)
        return button
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(theme: .purpleblue)
        button.setTitle("BACK".localized(), for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(back(sender:)), for: .touchUpInside)
        return button
    }()
    
    private let displayNameText: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(theme: .purpleblue)
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 5
        textField.textColor = UIColor.white
        textField.font = UIFont(name: FontRes.Avenir, size: 30)
        textField.text = "Ethan Xue"
        textField.textAlignment = NSTextAlignment.center
        return textField
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(className  + " : didLoad")
        view.backgroundColor = UIColor(theme: .purpleblue)
        
        displayNameText.delegate = self
        
        view.addSubview(backButton)
        view.addSubview(saveButton)
        
        setupMainView()
        setupBackButton()
        setupSaveButton()
    }
    
    deinit {
        print(className + " : deinitializing")
    }
    
    // MARK: Save button target
    
    @objc private func saveInfo() {
        view.endEditing(true)
        if didMakeChanges {
            didMakeChanges = false
        }
        let alert = UIAlertController(title: "SAVED".localized(), message: "SAVED_INFO".localized(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK".localized(), style: .default))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: DataReceiver
    
    func getData(data: AnyHashable) {
        self.data = data as? String
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        didMakeChanges = true
    }
    
    // MARK: Navigation
    
    @objc private func back(sender: UIBarButtonItem) {
        self.view.endEditing(true)
        if didMakeChanges {
            let alert = UIAlertController(title: "UNSAVED_CHANGES".localized(), message: "UNSAVED_CHANGES_INFO".localized(), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "CANCEL".localized(), style: .default))
            alert.addAction(UIAlertAction(title: "OK".localized(), style: .default) {_ in
                self.segueToProfileSettings()
            })
            present(alert, animated: true, completion: nil)
        }
        else {
            segueToProfileSettings()
        }
    }
    
    private func segueToProfileSettings() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Setup Views
    
    private func setupMainView() {
        guard let data = data else { return }
        switch(data) {
        case "CHANGE_PFP".localized():
            view.addSubview(displayNameText)
        case "EDIT_NAME".localized():
            view.addSubview(displayNameText)
            setupDisplayNameText()
        case "EDIT_PF_DESCRIPTION".localized():
            view.addSubview(displayNameText)
        default:
            print(className + " : An unknown error occured")
        }
    }
    
    private func setupDisplayNameText() {
        displayNameText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        displayNameText.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        displayNameText.heightAnchor.constraint(equalToConstant: 50).isActive = true
        displayNameText.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
    }
    
    private func setupBackButton() {
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setupSaveButton() {
        saveButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        saveButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
