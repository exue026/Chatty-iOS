//
//  ProfileEditController.swift
//  chatty
//
//  Created by Ethan Xue on 2017-08-01.
//  Copyright © 2017 xTech. All rights reserved.
//

import UIKit
import PromiseKit

protocol DataReceiver {
    func getData(data: AnyHashable)
}

class ProfileEditController: UIViewController, DataReceiver, UITextFieldDelegate, UITextViewDelegate  {
    
    // MARK: Properties

    private var data: String?
    private var didMakeChanges: Bool = false
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(theme: .purpleblue)
        button.setTitle("SAVE".localized(), for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
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
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(back(sender:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var nameText: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(theme: .purpleblue)
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 5
        textField.textColor = UIColor.white
        textField.font = UIFont(name: FontRes.Avenir, size: 28)
        textField.font = textField.font?.withSize(28)
        textField.textAlignment = NSTextAlignment.center
        textField.delegate = self
        textField.text = UserManagerService.shared().myUser?.displayName
        return textField
    }()
    
    private lazy var descriptionText: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = UIColor(theme: .purpleblue)
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 5
        textView.textColor = UIColor.white
        textView.font = UIFont(name: FontRes.Avenir, size: 22)
        textView.font = textView.font?.withSize(22)
        textView.textAlignment = NSTextAlignment.center
        textView.delegate = self
        textView.text = UserManagerService.shared().myUser?.descript
        return textView
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.printDidLoad()
        view.backgroundColor = UIColor(theme: .purpleblue)
        
        view.addSubview(backButton)
        view.addSubview(saveButton)
        
        setupMainView()
        setupBackButton()
        setupSaveButton()
    }
    
    deinit {
        self.printDeinit()
    }
    
    // MARK: Save button target
    
    @objc private func saveInfo() {
        view.endEditing(true)
        updateUserInfo().then { _ -> Void in
            if self.didMakeChanges {
                self.didMakeChanges = false
            }
            UserManagerService.shared().updatedInfo = true
            let alert = UIAlertController(title: "SAVED".localized(), message: "SAVED_INFO".localized(), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK".localized(), style: .default))
            self.present(alert, animated: true, completion: nil)
        }.catch { (error: Error) in
            print(error)
        }
    }
    
    // MARK: Helper functions
    
    private func updateUserInfo() -> Promise<Data?> {
        guard let data = data, let nameText = nameText.text, let descriptionText = descriptionText.text else {
            return Promise(error: BaseError.unknownError)
        }
        switch(data) {
        case "EDIT_NAME".localized():
            UserManagerService.shared().myUser?.displayName = nameText
            return UserManagerService.shared().updateUserInfo(info: [User.UserKeys.name.stringValue : nameText])
        case "EDIT_PF_DESCRIPTION".localized():
            UserManagerService.shared().myUser?.descript = descriptionText
            return UserManagerService.shared().updateUserInfo(info: [User.UserKeys.description.stringValue : descriptionText])
        default:
            return Promise(error: BaseError.unknownError)
        }
    }
    
    // MARK: DataReceiver
    
    func getData(data: AnyHashable) {
        self.data = data as? String
    }
    
    // MARK: UITextFieldDelegate and UITextViewDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        didMakeChanges = true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
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
            view.addSubview(nameText)
        case "EDIT_NAME".localized():
            view.addSubview(nameText)
            setupNameText()
        case "EDIT_PF_DESCRIPTION".localized():
            view.addSubview(descriptionText)
            setupDescriptionText()
        default:
            print(className + " : An unknown error occured")
        }
    }
    
    private func setupNameText() {
        nameText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameText.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        nameText.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nameText.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
    }
    
    private func setupDescriptionText() {
        descriptionText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        descriptionText.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        descriptionText.heightAnchor.constraint(equalToConstant: 150).isActive = true
        descriptionText.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
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
