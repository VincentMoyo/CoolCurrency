//
//  RegisterViewController.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/28.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class RegisterViewController: UIViewController {
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var activityLoader: UIActivityIndicatorView!
    
    private lazy var viewModel = RegisterViewModel(authenticationRepository: AuthenticationRepository(authenticationReference: Auth.auth()),
                                                   delegate: self,
                                                   database: DatabaseRepository(databaseReference: Database.database().reference(),
                                                                                storageReference: Storage.storage().reference()))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityLoader.isHidden = true
    }
    
    @IBAction private func registerButtonPressed(_ sender: UIButton) {
        if let email = emailTextField.text,
           let password = passwordTextField.text {
            viewModel.registerUser(email, password)
            activateActivityIndicatorView()
        }
    }
    
    private func activateActivityIndicatorView() {
        activityLoader.isHidden = false
        activityLoader.hidesWhenStopped = true
        activityLoader.startAnimating()
    }
}

extension RegisterViewController: ViewModelDelegate {
    
    func bindViewModel() {
            self.performSegue(withIdentifier: "RegisterCell", sender: self)
            self.activityLoader.stopAnimating()
    }
}
