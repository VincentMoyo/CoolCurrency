//
//  RegisterViewController.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/28.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    
    private lazy var viewModel = RegisterViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityLoader.isHidden = true
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
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
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "RegisterCell", sender: self)
            self.activityLoader.stopAnimating()
        }
    }
}
