//
//  SettingsViewController.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/29.
//

import UIKit

class SettingsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet private weak var activityLoader: UIActivityIndicatorView!
    @IBOutlet private weak var firstNameLabel: UIButton!
    @IBOutlet private weak var lastNameLabel: UIButton!
    @IBOutlet private weak var profilePictureImage: UIImageView!
    @IBOutlet private weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var datePicker: UIDatePicker!
    
    private lazy var viewModel = SettingsViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityLoader.isHidden = true
        viewModel.loadUserSettingsFromDatabase()
    }
    
    @IBAction func logOutPressed(_ sender: UIButton) {
        viewModel.signOutUser()
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
        viewModel.updateDateOfBirth(dateResult)
    }
    
    @IBAction func genderIndexChangedPressed(_ sender: Any) {
        viewModel.updateGender(genderSegmentedControl.titleForSegment(at: genderSegmentedControl.selectedSegmentIndex)!)
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
        viewModel.checkUserList()
        retrieveUserInformation()
        self.activityLoader.stopAnimating()
    }
    
    func retrieveUserInformation() {
        self.firstNameLabel.setTitle(viewModel.firstName, for: .normal)
        self.lastNameLabel.setTitle(viewModel.lastName, for: .normal)
        genderSegmentedControl.selectedSegmentIndex = viewModel.gender
        datePicker.setDate(viewModel.birthDate, animated: true)
    }
    
    private func bindSignOutSettingsViewModel() {
            self.performSegue(withIdentifier: "welcome", sender: self)
            self.activityLoader.stopAnimating()
    }
}

extension SettingsViewController {
    
    private func setupProfileNames(_ nameLabel: UIButton, isFirstName firstName: Bool) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Set Name",
                                      message: "Set your username to complete your profile account setup",
                                      preferredStyle: .alert)
        
        let actions = UIAlertAction(title: "Change", style: .default, handler: { (_) in
            if firstName {
                guard let newFirstName = textField.text else {
                    return
                }
                nameLabel.setTitle(newFirstName, for: .normal)
                self.viewModel.updateFirstName(newFirstName)
            } else {
                guard let newLastName = textField.text else {
                    return
                }
                nameLabel.setTitle(newLastName, for: .normal)
                self.viewModel.updateLastName(newLastName)
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
