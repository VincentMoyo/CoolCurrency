//
//  WelcomeViewController.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/28.
//

import UIKit

class WelcomeViewController: UIViewController {

    var welcomeViewModel = WelcomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        if welcomeViewModel.sigInInUser() {
            // self.performSegue(withIdentifier: "LoginCell", sender: self)
        }
    }
}
