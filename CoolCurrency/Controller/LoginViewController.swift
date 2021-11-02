//
//  LoginViewController.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/28.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var activityLoader: UIActivityIndicatorView!
    
    private lazy var viewModel = LoginViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityLoader.isHidden = true
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
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

extension LoginViewController: ViewModelDelegate {
    func bindViewModel() {
            self.performSegue(withIdentifier: "LoginCell", sender: self)
            self.activityLoader.stopAnimating()
    }
}
