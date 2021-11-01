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
        bindSignOutSettingsViewModel()
    }
    
    @IBAction func setProfilePicturePressed(_ sender: UIButton) {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        self.present(myPickerController, animated: true, completion: nil)
    }
    
    @IBAction func setFirstNamePressed(_ sender: UIButton) {
        setupProfileNames(firstNameLabel, isFirstName: true)
    }
    
    @IBAction func setLastNamePressed(_ sender: UIButton) {
        setupProfileNames(lastNameLabel, isFirstName: false)
    }
    
    @IBAction func dateOfBirthPressed(_ sender: UIDatePicker) {
        Constants.FormatForDate.dateFormatterGet.dateFormat = Constants.FormatForDate.DateFormate
        let dateResult = Constants.FormatForDate.dateFormatterGet.string(from: datePicker.date)
        settingsViewModel.updateDateOfBirth(dateResult)
    }
    
    @IBAction func genderIndexChangedPressed(_ sender: Any) {
        settingsViewModel.updateGender(genderSegmentedControl.titleForSegment(at: genderSegmentedControl.selectedSegmentIndex)!)
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
            if settings.key == "FirstName" {
                self.firstNameLabel.setTitle(settings.value, for: .normal)
            } else if settings.key == "LastName" {
                self.lastNameLabel.setTitle(settings.value, for: .normal)
            } else if settings.key == "Gender" {
                if settings.value == "Female" {
                    genderSegmentedControl.selectedSegmentIndex = 0
                } else {
                    genderSegmentedControl.selectedSegmentIndex = 1
                }
            } else if settings.key == "Date of Birth" {
                Constants.FormatForDate.dateFormatterGet.dateFormat = Constants.FormatForDate.DateFormate
                let dateResult = Constants.FormatForDate.dateFormatterGet.date(from: settings.value)
                self.datePicker.setDate(dateResult!, animated: true)
            }
        }
        self.activityLoader.stopAnimating()
    }
    
    private func bindSignOutSettingsViewModel() {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "welcome", sender: self)
                    self.activityLoader.stopAnimating()
                }
    }
}

extension SettingsViewController {
    
    private func setupProfileNames(_ nameLabel: UIButton, isFirstName firstName: Bool) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Set Name", message: "Set your username to complete your profile account setup", preferredStyle: .alert)
        let actions = UIAlertAction(title: "Change", style: .default, handler: { (_) in
            if firstName {
                nameLabel.setTitle(textField.text, for: .normal)
                self.settingsViewModel.updateFirstName(textField.text!)
            } else {
                nameLabel.setTitle(textField.text, for: .normal)
                self.settingsViewModel.updateLastName(textField.text!)
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
