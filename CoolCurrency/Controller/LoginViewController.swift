//
//  LoginViewController.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/28.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    
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
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "LoginCell", sender: self)
            self.activityLoader.stopAnimating()
        }
    }
}
