//
//  ViewController.swift
//  chatty
//
//  Created by Ethan Xue on 2017-07-08.
//  Copyright © 2017 xTech. All rights reserved.
//

import UIKit

class LoginController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private let chattyLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "chatty_logo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let inputsView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5.0
        view.layer.masksToBounds = true
        return view
    }()
    
    private let usernameTF: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(string: "USERNAME".localized(), attributes: [NSAttributedStringKey.foregroundColor: UIColor(theme: .grey)])
        textField.backgroundColor = UIColor.white
        textField.returnKeyType = .done
        return textField
    }()
    
    private let emailTF: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(string: "EMAIL".localized(), attributes: [NSAttributedStringKey.foregroundColor: UIColor(theme: .grey)])
        textField.backgroundColor = UIColor.white
        textField.returnKeyType = .done
        return textField
    }()
    
    private let passwordTF: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(string: "PASSWORD".localized(), attributes: [NSAttributedStringKey.foregroundColor: UIColor(theme: .grey)])
        textField.isSecureTextEntry = true
        textField.backgroundColor = UIColor.white
        textField.returnKeyType = .done
        return textField
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(theme: .thistle)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.setTitle("REGISTER".localized(), for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return button
    }()
    
    private let separatorView1: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(theme: .thistle)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let separatorView2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(theme: .thistle)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(theme: .purpleblue)
        
        usernameTF.delegate = self
        emailTF.delegate = self
        passwordTF.delegate = self
        
        view.addSubview(chattyLogo)
        view.addSubview(inputsView)
        view.addSubview(registerButton)
        
        setupChattyLogo()
        setupInputsView()
        setupRegisterButton()
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: Setup Views
    
    private func setupChattyLogo() {
        chattyLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        chattyLogo.bottomAnchor.constraint(equalTo: inputsView.topAnchor, constant: -20).isActive = true
        chattyLogo.widthAnchor.constraint(equalToConstant: 100).isActive = true
        chattyLogo.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func setupInputsView() {
        inputsView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/4).isActive = true
        
        inputsView.addSubview(usernameTF)
        inputsView.addSubview(separatorView1)
        inputsView.addSubview(emailTF)
        inputsView.addSubview(separatorView2)
        inputsView.addSubview(passwordTF)
        
        setupUsernameTF()
        setupSeparatorView1()
        setupEmailTF()
        setupSeparatorView2()
        setupPasswordTF()
    }
    
    private func setupRegisterButton() {
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: inputsView.bottomAnchor, constant: 12).isActive = true
        registerButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        registerButton.heightAnchor.constraint(equalTo: inputsView.heightAnchor, multiplier: 1/4).isActive = true
    }
    
    private func setupUsernameTF() {
        usernameTF.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 12).isActive = true
        usernameTF.topAnchor.constraint(equalTo: inputsView.topAnchor).isActive = true
        usernameTF.widthAnchor.constraint(equalTo: inputsView.widthAnchor, constant: -12).isActive = true
        usernameTF.heightAnchor.constraint(equalTo: inputsView.heightAnchor, multiplier: 1/3).isActive = true
    }
    
    private func setupSeparatorView1() {
        separatorView1.topAnchor.constraint(equalTo: usernameTF.bottomAnchor).isActive = true
        separatorView1.leftAnchor.constraint(equalTo: inputsView.leftAnchor).isActive = true
        separatorView1.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        separatorView1.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
    
    private func setupEmailTF() {
        emailTF.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 12).isActive = true
        emailTF.topAnchor.constraint(equalTo: separatorView1.bottomAnchor).isActive = true
        emailTF.widthAnchor.constraint(equalTo: inputsView.widthAnchor, constant: -12).isActive = true
        emailTF.heightAnchor.constraint(equalTo: inputsView.heightAnchor, multiplier: 1/3).isActive = true
    }
    
    private func setupSeparatorView2() {
        separatorView2.topAnchor.constraint(equalTo: emailTF.bottomAnchor).isActive = true
        separatorView2.leftAnchor.constraint(equalTo: inputsView.leftAnchor).isActive = true
        separatorView2.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        separatorView2.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
    
    private func setupPasswordTF() {
        passwordTF.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 12).isActive = true
        passwordTF.topAnchor.constraint(equalTo: separatorView2.bottomAnchor).isActive = true
        passwordTF.widthAnchor.constraint(equalTo: inputsView.widthAnchor, constant: -12).isActive = true
        passwordTF.heightAnchor.constraint(equalTo: inputsView.heightAnchor, multiplier: 1/3).isActive = true
    }
    
}
