//
//  WelcomeViewController.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/28.
//

import UIKit
import FirebaseAuth

class WelcomeViewController: UIViewController {

    private lazy var viewModel = WelcomeViewModel(authenticationRepository: AuthenticationRepository(authenticationReference: Auth.auth()))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if viewModel.isUserSignedIn {
            self.performSegue(withIdentifier: "QuickSignIn", sender: self)
        }
    }
}
