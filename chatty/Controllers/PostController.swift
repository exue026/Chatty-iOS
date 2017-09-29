//
//  PostController.swift
//  chatty
//
//  Created by Ethan Xue on 2017-09-15.
//  Copyright © 2017 xTech. All rights reserved.
//

import UIKit
import PromiseKit

class PostController: UIViewController, UITextViewDelegate {
    
    private var didMakeChanges: Bool = false
    
    private lazy var postHead: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = UIColor(theme: .purpleblue, opacity: 0.7)
        
        textView.textColor = UIColor.white
        textView.font = UIFont(name: FontRes.Avenir, size: 20)
        textView.font = textView.font?.withSize(20)
        textView.delegate = self
        textView.text = "POST_HEAD".localized()
        textView.textContainerInset = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)
        textView.tag = 0
        return textView
    }()
    
    private lazy var postBody: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = UIColor(theme: .purpleblue, opacity: 0.7)
        textView.textColor = UIColor.white
        textView.font = UIFont(name: FontRes.Avenir, size: 18)
        textView.font = textView.font?.withSize(18)
        textView.delegate = self
        textView.text = "POST_BODY".localized()
        textView.textContainerInset = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)
        textView.tag = 1
        return textView
    }()
    
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView(imageName: "create_post_background")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var spinner = LoadingSpinner(frame: CGRect.zero)
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.printDidLoad()
        view.addSubview(backgroundImage)
        setupBackgroundImage()
        
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = "CREATE_POST".localized()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "CANCEL".localized(), style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "POST".localized(), style: .plain, target: self, action: #selector(createPost))
        
        view.addSubview(postBody)
        setupPostBody()
        view.addSubview(postHead)
        setupPostHead()
        view.addSubview(spinner)
        setupSpinner()
    }
    
    deinit {
        self.printDeinit()
    }
    
    @objc private func createPost() {
        self.view.endEditing(true)
        if !postHead.text.trim().isEmpty, !postBody.text.trim().isEmpty {
            let message = ["head": postHead.text.trim(), "body": postBody.text.trim()]
            spinner.start()
            firstly {
                APIService.shared().createPost(forId: UserManagerService.shared().myUser!.id!, messageContents: message)
            }.then { _ -> Void in
                
                let alert = UIAlertController(title: "CONFIRM_POST".localized(), message: "CONFIRM_POST_MSG".localized(), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "CANCEL".localized(), style: .default))
                alert.addAction(UIAlertAction(title: "OK".localized(), style: .default) {_ in
                    UserManagerService.shared().posts?.insert(Post(title: self.postHead.text.trim(), text: self.postBody.text.trim()), at: 0)
                    UserManagerService.shared().updatedPosts = true
                    self.dismiss(animated: true, completion: nil)
                })
                self.present(alert, animated: true) {
                    self.spinner.stop()
                }
            }.catch { error in
                self.spinner.stop()
                print(error)
            }
        }
    }
    
    @objc private func handleCancel() {
        self.view.endEditing(true)
        if didMakeChanges {
            let alert = UIAlertController(title: "UNSAVED_CHANGES".localized(), message: "UNSAVED_CHANGES_INFO".localized(), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "CANCEL".localized(), style: .default))
            alert.addAction(UIAlertAction(title: "OK".localized(), style: .default) {_ in
                self.dismiss(animated: true, completion: nil)
            })
            present(alert, animated: true, completion: nil)
        }
        else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // UITextViewDelegate
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let maxNumChars = textView.tag == 0 ? 32 : 150
        return newText.characters.count < maxNumChars
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        didMakeChanges = true
    }
    
    // Setup views
    
    private func setupBackgroundImage() {
        backgroundImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupPostBody() {
        postBody.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        postBody.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        postBody.heightAnchor.constraint(equalToConstant: 200).isActive = true
        postBody.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    private func setupPostHead() {
        postHead.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        postHead.heightAnchor.constraint(equalToConstant: 50).isActive = true
        postHead.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        postHead.bottomAnchor.constraint(equalTo: postBody.topAnchor, constant: -20).isActive = true
    }
    
    private func setupSpinner() {
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
