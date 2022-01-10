//
//  LoginViewController.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/28.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInUIDelegate {
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var activityLoader: UIActivityIndicatorView!
    @IBOutlet private weak var firebaseLogin: UIButton!
    @IBOutlet private weak var additionalSignInMethods: UILabel!
    
    private var loginObserver: NSObjectProtocol?
    private let googleLogInButton = GIDSignInButton()
    private let facebookLoginButton: FBLoginButton = {
        let button = FBLoginButton()
        button.permissions = ["email", "public_profile"]
        return button
    }()
    
    private lazy var viewModel = LoginViewModel(authenticationRepository: AuthenticationRepository(authenticationReference: Auth.auth()),
                                                delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginObserver()
        GIDSignIn.sharedInstance()?.uiDelegate = self
        facebookLoginButton.delegate = self
        activityLoader.isHidden = true
        self.activityLoader.stopAnimating()
        view.addSubview(facebookLoginButton)
        view.addSubview(googleLogInButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        facebookLoginButton.frame = CGRect(x: firebaseLogin.frame.origin.x,
                                           y: additionalSignInMethods.frame.origin.y + 80,
                                           width: firebaseLogin.frame.width,
                                           height: firebaseLogin.frame.height)
        googleLogInButton.frame = CGRect(x: facebookLoginButton.frame.origin.x,
                                         y: facebookLoginButton.frame.origin.y + 80,
                                         width: facebookLoginButton.frame.width,
                                         height: facebookLoginButton.frame.height)
    }
    
    deinit {
        if let loginObserver = loginObserver {
            NotificationCenter.default.removeObserver(loginObserver)
        }
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
    
    private func setupLoginObserver() {
        loginObserver = NotificationCenter.default.addObserver(forName: .didLogInNotification,
                                                               object: nil,
                                                               queue: .main,
                                                               using: { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.bindViewModel()
        })
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

 // MARK: - Facebook Login Delegate
extension LoginViewController: LoginButtonDelegate {
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) { }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        guard let token = result?.token?.tokenString else {
            Alerts.showUserNotificationDidInitiate(for: self, "Facebook login failed")
            return
        }
        
        let credential = FacebookAuthProvider.credential(withAccessToken: token)
        FirebaseAuth.Auth.auth().signIn(with: credential, completion: { authResult, error in
            guard authResult != nil, error == nil else {
                Alerts.showUserNotificationDidInitiate(for: self, "Credential failed")
                return
            }
            self.bindViewModel()
        })
    }
}
