//
//  NavigationViewController.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/11/15.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class NavigationViewController: UITabBarController {
    
    @IBOutlet private var profilePictureButton: UIBarButtonItem!
    
    private let imageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 40, height: 40.0))
    private lazy var viewModel = NavigationViewModel(delegate: self,
                                                     database: DatabaseRepository(databaseReference: Database.database().reference(),
                                                                                  storageReference: Storage.storage().reference()),
                                                     authenticationRepository: AuthenticationRepository(authenticationReference: Auth.auth()))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadUserSettingsFromDatabase()
        setupImageView()
        setupTapGesture()
    }
    
    private func setupImageView() {
        guard let imageData = viewModel.profilePictureDataImage else { return }
        imageView.image = UIImage(data: imageData)?.withRenderingMode(.alwaysOriginal)
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.layer.cornerRadius = 20.0
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        profilePictureButton = UIBarButtonItem(customView: imageView)
        navigationItem.setRightBarButton(profilePictureButton, animated: false)
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(NavigationViewController.imageTapped(gesture:)))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
    }
    
    @objc func imageTapped(gesture: UIGestureRecognizer) {
        if (gesture.view as? UIImageView) != nil {
            performSegue(withIdentifier: "settingsCell", sender: self)
        }
    }
}

// MARK: - View Model Delegate
extension NavigationViewController: ViewModelDelegate {
    
    func bindViewModel() {
        setupImageView()
    }
}
