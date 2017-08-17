//
//  LoginController.swift
//  chatty
//
//  Created by Ethan Xue on 2017-07-08.
//  Copyright © 2017 xTech. All rights reserved.
//

import UIKit
import Firebase
import PromiseKit

class LoginController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    
    private let chattyLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "chatty_logo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private var loginRegisterSegmentedControl: UISegmentedControl = {
        let segmentedController = UISegmentedControl(items: ["LOGIN".localized(), "REGISTER".localized()])
        segmentedController.translatesAutoresizingMaskIntoConstraints = false
        segmentedController.tintColor = UIColor.white
        segmentedController.selectedSegmentIndex = 0
        segmentedController.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        return segmentedController
    }()
    
    private var inputsViewHeightAnchor: NSLayoutConstraint?
    
    private let inputsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 5.0
        view.layer.masksToBounds = true
        return view
    }()
    
    private var usernameTFHeightAnchor: NSLayoutConstraint?
    
    private lazy var usernameTF: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.backgroundColor = UIColor.white
        textField.attributedPlaceholder = NSAttributedString(string: "USERNAME".localized(), attributes: [NSAttributedStringKey.foregroundColor: UIColor(theme: .grey)])
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        return textField
    }()
    
    private var emailTFHeightAnchor: NSLayoutConstraint?
    
    private lazy var emailTF: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.white
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(string: "EMAIL".localized(), attributes: [NSAttributedStringKey.foregroundColor: UIColor(theme: .grey)])
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        return textField
    }()
    
    private var passwordTFHeightAnchor: NSLayoutConstraint?
    
    private lazy var passwordTF: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor.white
        textField.attributedPlaceholder = NSAttributedString(string: "PASSWORD".localized(), attributes: [NSAttributedStringKey.foregroundColor: UIColor(theme: .grey)])
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        return textField
    }()
    
    private let loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(theme: .thistle)
        button.setTitle("LOGIN".localized(), for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleLoginRegistration), for: .touchUpInside)
        return button
    }()
    
    private var separatorView1HeightAnchor: NSLayoutConstraint?
    
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
    
    private lazy var spinner = LoadingSpinner(frame: CGRect.zero)
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.printDidLoad()
        
        view.backgroundColor = UIColor(theme: .purpleblue)
        
        view.addSubview(chattyLogo)
        view.addSubview(loginRegisterSegmentedControl)
        view.addSubview(inputsView)
        view.addSubview(loginRegisterButton)
        view.addSubview(spinner)
        
        setupChattyLogo()
        setupLoginRegisterSegmentedControl()
        setupInputsView()
        setupRegisterButton()
        setupSpinner()
    }
    
    deinit {
        self.printDeinit()
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: loginRegisterSegmentedControl
    
    @objc private func handleLoginRegisterChange() {
        self.view.endEditing(true)
        clearInputs()
        let title = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, for: .normal)
        
        inputsViewHeightAnchor?.constant = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 100 : 150
        
        let usernameTFMultiplier: CGFloat = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0 : 1/3
        let emailTFMultiplier: CGFloat = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3
        let passwordTFMultiplier: CGFloat = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3
        let separatorView1Constant: CGFloat = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0 : 2
        
        usernameTFHeightAnchor?.isActive = false
        emailTFHeightAnchor?.isActive = false
        passwordTFHeightAnchor?.isActive = false
        separatorView1HeightAnchor?.isActive = false
        
        usernameTFHeightAnchor = usernameTF.heightAnchor.constraint(equalTo: inputsView.heightAnchor, multiplier: usernameTFMultiplier)
        emailTFHeightAnchor = emailTF.heightAnchor.constraint(equalTo: inputsView.heightAnchor, multiplier: emailTFMultiplier)
        passwordTFHeightAnchor = passwordTF.heightAnchor.constraint(equalTo: inputsView.heightAnchor, multiplier: passwordTFMultiplier)
        separatorView1HeightAnchor = separatorView1.heightAnchor.constraint(equalToConstant: separatorView1Constant)
        
        usernameTFHeightAnchor?.isActive = true
        emailTFHeightAnchor?.isActive = true
        passwordTFHeightAnchor?.isActive = true
        separatorView1HeightAnchor?.isActive = true
    }
    
    // MARK: loginRegisterButton target
    
    @objc private func handleLoginRegistration() {
        self.view.endEditing(true)
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            handleLogin()
        }
        else {
            handleRegistration()
        }
    }
    
    private func handleLogin() {
        spinner.start()
        guard let email = emailTF.text, let password = passwordTF.text else { return }
        firstly {
            FirebaseService.shared().signInUser(email: email, password: password)
        }.then { (idToken: String) -> Promise<User> in
            APIService.shared().getUser(forIdToken: idToken)
        }.then { (user: User) -> Void in
            UserManagerService.shared().myUser = user
            UserManagerService.shared().updatedInfo = true
            self.segueToMainTabBarController()
        }.catch { error in
            let alert = UIAlertController(title: "ERROR".localized(), message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK".localized(), style: .default))
            self.present(alert, animated: true, completion: nil)
        }.always {
            self.spinner.stop()
        }
    }
    
    private func handleRegistration() {
        spinner.start()
        guard let username = usernameTF.text, let email = emailTF.text, let password = passwordTF.text else { return }
        var alertTitle = "", alertMessage = "", alertAction = UIAlertAction()
        
        firstly {
            FirebaseService.shared().createUser(username: username, email: email, password: password)
        }.then { _ -> Void in
            alertTitle = "VERIFY_EMAIL_TITLE".localized()
            alertMessage = "VERIFY_EMAIL_MSG".localized()
            alertAction = UIAlertAction(title: "OK".localized(), style: .default) { _ in
                self.clearInputs()
                self.loginRegisterSegmentedControl.selectedSegmentIndex = 0
                self.handleLoginRegisterChange()
            }
        }.catch { error in
                alertTitle = "ERROR".localized()
                alertMessage = error.localizedDescription
                alertAction = UIAlertAction(title: "OK".localized(), style: .default, handler: nil)
        }.always {
                self.spinner.stop()
                let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: Helper functions
    
    private func clearInputs() {
        usernameTF.text = ""
        emailTF.text = ""
        passwordTF.text = ""
    }
    
    // MARK: Navigation
    
    private func segueToMainTabBarController() {
         dismiss(animated: true, completion: nil)
    }
    
    // MARK: Setup Views
    
    private func setupChattyLogo() {
        chattyLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        chattyLogo.bottomAnchor.constraint(equalTo: inputsView.topAnchor, constant: -70).isActive = true
        chattyLogo.widthAnchor.constraint(equalToConstant: 150).isActive = true
        chattyLogo.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    private func setupLoginRegisterSegmentedControl() {
        loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        loginRegisterSegmentedControl.bottomAnchor.constraint(equalTo: inputsView.topAnchor, constant: -12).isActive = true
        loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setupInputsView() {
        inputsView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsViewHeightAnchor = inputsView.heightAnchor.constraint(equalToConstant: 100)
        inputsViewHeightAnchor?.isActive = true
        
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
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: inputsView.bottomAnchor, constant: 12).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }
    
    private func setupUsernameTF() {
        usernameTF.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 12).isActive = true
        usernameTF.topAnchor.constraint(equalTo: inputsView.topAnchor).isActive = true
        usernameTF.widthAnchor.constraint(equalTo: inputsView.widthAnchor, constant: -12).isActive = true
        usernameTFHeightAnchor = usernameTF.heightAnchor.constraint(equalTo: inputsView.heightAnchor, multiplier: 0)
        usernameTFHeightAnchor?.isActive = true
    }
    
    private func setupSeparatorView1() {
        separatorView1.topAnchor.constraint(equalTo: usernameTF.bottomAnchor).isActive = true
        separatorView1.leftAnchor.constraint(equalTo: inputsView.leftAnchor).isActive = true
        separatorView1.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        separatorView1HeightAnchor = separatorView1.heightAnchor.constraint(equalToConstant: 0)
        separatorView1HeightAnchor?.isActive = true
    }
    
    private func setupEmailTF() {
        emailTF.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 12).isActive = true
        emailTF.topAnchor.constraint(equalTo: separatorView1.bottomAnchor).isActive = true
        emailTF.widthAnchor.constraint(equalTo: inputsView.widthAnchor, constant: -12).isActive = true
        emailTFHeightAnchor =  emailTF.heightAnchor.constraint(equalTo: inputsView.heightAnchor, multiplier: 1/2)
        emailTFHeightAnchor?.isActive = true
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
        passwordTFHeightAnchor =  passwordTF.heightAnchor.constraint(equalTo: inputsView.heightAnchor, multiplier: 1/2)
        passwordTFHeightAnchor?.isActive = true
    }
    
    private func setupSpinner() {
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
