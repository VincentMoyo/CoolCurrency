//
//  SettingsViewController.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/29.
//

import UIKit

class SettingsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    @IBOutlet weak var firstNameLabel: UIButton!
    @IBOutlet weak var lastNameLabel: UIButton!
    @IBOutlet weak var profilePictureImage: UIImageView!
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    private lazy var settingsViewModel = SettingsViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityLoader.isHidden = true
        settingsViewModel.loadUserSettingsFromDatabase()
    }
    
    @IBAction func logOutPressed(_ sender: UIButton) {
        settingsViewModel.signOutUser()
        activateActivityIndicatorView()
    }
    
    @IBAction func setProfilePicturePressed(_ sender: UIButton) {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        self.present(myPickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        profilePictureImage.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        self.dismiss(animated: true, completion: nil)
    }
    
    private func activateActivityIndicatorView() {
        activityLoader.isHidden = false
        activityLoader.hidesWhenStopped = true
        activityLoader.startAnimating()
    }
}

extension SettingsViewController: ViewModelDelegate {
    
    func bindViewModel() {
        self.settingsViewModel.userSettingsList.forEach { settings in
            self.firstNameLabel.setTitle(settings.firstName, for: .normal)
            self.lastNameLabel.setTitle(settings.lastName, for: .normal)
            Constants.FormatForDate.dateFormatterGet.dateFormat = Constants.FormatForDate.DateFormate
            let dateResult = Constants.FormatForDate.dateFormatterGet.date(from: settings.dateOfBirth)
            self.datePicker.setDate(dateResult!, animated: true)
        }
        self.activityLoader.stopAnimating()
    }
}

extension SettingsViewController {
    
    private func setupProfileNames(_ nameLabel: UIButton, isFirstName firstName: Bool) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Set Name", message: "Set your username to complete your profile account setup", preferredStyle: .alert)
        let actions = UIAlertAction(title: "Change", style: .default, handler: { (_) in
            if firstName {
                nameLabel.setTitle(textField.text, for: .normal)
                // self.settingsViewModel.updateFirstName(textField.text!)
            } else {
                nameLabel.setTitle(textField.text, for: .normal)
                // self.settingsViewModel.updateLastName(textField.text!)
            }
        })
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "New Name"
            textField = alertTextField
        }
        alert.addAction(actions)
        present(alert, animated: true, completion: nil)
    }
}
