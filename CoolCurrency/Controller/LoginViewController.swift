//
//  LoginViewController.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/28.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var activityLoader: UIActivityIndicatorView!
    
    private lazy var viewModel = LoginViewModel(authenticationRepository: AuthenticationRepository(authenticationReference: Auth.auth()),
                                                delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityLoader.isHidden = true
        self.activityLoader.stopAnimating()
    }
    
    @IBAction private func loginButtonPressed(_ sender: UIButton) {
        if let email = self.emailTextField.text,
           let password = self.passwordTextField.text {
            viewModel.authenticateUser(email, password)
            activateActivityIndicatorView()
        }
    }
    
    private func activateActivityIndicatorView() {
        activityLoader.isHidden = false
        activityLoader.hidesWhenStopped = true
        activityLoader.startAnimating()
    }
}

// MARK: - View Model Delegate
extension LoginViewController: AuthenticationViewModelDelegate {
    
    func bindViewModel() {
            self.performSegue(withIdentifier: "LoginCell", sender: self)
    }
    
    func stopActivityLoader() {
        self.activityLoader.stopAnimating()
    }
}
