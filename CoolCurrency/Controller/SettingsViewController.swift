//
//  SettingsViewController.swift
//  CoolCurrency
//
//  Created by Vincent Moyo on 2021/10/29.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class SettingsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet private weak var activityLoader: UIActivityIndicatorView!
    @IBOutlet private weak var firstNameLabel: UIButton!
    @IBOutlet private weak var lastNameLabel: UIButton!
    @IBOutlet private weak var profilePictureImage: UIImageView!
    @IBOutlet private weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var datePicker: UIDatePicker!
    @IBOutlet private weak var measurementUnitSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var defaultCurrencyPickerViewButton: UIButton!
    
    private let screenWidth = UIScreen.main.bounds.width - 10
    private let screenHeight = UIScreen.main.bounds.width / 2
    
    private lazy var viewModel = SettingsViewModel(databaseRepository: DatabaseRepository(databaseReference: Database.database().reference(),
                                                                                          storageReference: Storage.storage().reference()),
                                                   authenticationRepository: AuthenticationRepository(authenticationReference: Auth.auth()),
                                                   delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activateActivityIndicatorView()
        viewModel.loadUserSettingsFromDatabase()
    }
    
    @IBAction private func logOutPressed(_ sender: UIButton) {
        viewModel.signOutCurrentUser()
        activateActivityIndicatorView()
    }
    
    @IBAction private func setProfilePicturePressed(_ sender: UIButton) {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        myPickerController.allowsEditing = true
        
        self.present(myPickerController, animated: true, completion: nil)
    }
    
    @IBAction private func setFirstNamePressed(_ sender: UIButton) {
        Alerts.showUpdateFirstNameAlert(for: self, buttonLabelText: firstNameLabel, updateNamesToDatabase: viewModel.updateFirstName(_:))
    }
    
    @IBAction private func setLastNamePressed(_ sender: UIButton) {
        Alerts.showUpdateLastNameAlert(for: self, buttonLabelText: lastNameLabel, updateNamesToDatabase: viewModel.updateLastName(_:))
    }
    
    @IBAction private func dateOfBirthPressed(_ sender: UIDatePicker) {
        Constants.FormatForDate.dateFormatterGet.dateFormat = Constants.FormatForDate.DateFormate
        let dateResult = Constants.FormatForDate.dateFormatterGet.string(from: datePicker.date)
        viewModel.updateDateOfBirth(dateResult)
    }
    
    @IBAction private func genderIndexChangedPressed(_ sender: Any) {
        guard let forSegmentedControl = genderSegmentedControl.titleForSegment(at: genderSegmentedControl.selectedSegmentIndex) else { return }
        viewModel.updateGender(forSegmentedControl)
    }
    
    @IBAction private func measurementUnitIndexPressed(_ sender: UISegmentedControl) {
        guard let measurementUnitSegmentedControl = measurementUnitSegmentedControl.titleForSegment(at: measurementUnitSegmentedControl.selectedSegmentIndex)
        else { return }
        viewModel.updateMeasurementUnit(measurementUnitSegmentedControl)
    }
    
    @IBAction private func popUpDefaultCurrencyPicker(_ sender: Any) {
        let pickerViewController = UIViewController()
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        
        setupDefaultCurrencyPickerView(for: pickerView)
        setLayoutOfPickerViewController(for: pickerViewController, with: pickerView)
        setupDefaultCurrencyPickerAlert(for: pickerViewController, with: pickerView)
    }
    
    @IBAction private func resetEmailPressed(_ sender: UIButton) {
        Alerts.showResetEmailAlert(for: self, updateNamesToDatabase: viewModel.resetEmail(newEmail:))
    }
    
    private func activateActivityIndicatorView() {
        activityLoader.hidesWhenStopped = true
        activityLoader.startAnimating()
    }
    
// MARK: - Set up Image Picker Controller
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        guard let imageData = image.pngData() else { return }
        
        viewModel.updateProfilePicture(imageData)

        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Picker View Mdethods
extension SettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
        label.text = viewModel.currencyList[row]
        label.sizeToFit()
        return label
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        viewModel.currencyList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        60
    }
    
    private func setupDefaultCurrencyPickerView(for pickerView: UIPickerView) {
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.selectRow(viewModel.selectedRow, inComponent: 0, animated: false)
    }
    
    private func setLayoutOfPickerViewController(for pickerViewController: UIViewController, with pickerView: UIPickerView) {
        pickerViewController.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
        pickerViewController.view.addSubview(pickerView)
        pickerView.centerXAnchor.constraint(equalTo: pickerViewController.view.centerXAnchor).isActive = true
        pickerView.centerYAnchor.constraint(equalTo: pickerViewController.view.centerYAnchor).isActive = true
    }
}

// MARK: - View Model Delegates
extension SettingsViewController: SettingsViewModelDelegate {
    
    func signOutBindViewModel() {
        self.performSegue(withIdentifier: "welcome", sender: self)
        self.activityLoader.stopAnimating()
    }
    
    func bindViewModel() {
        retrieveUserInformation()
        self.activityLoader.stopAnimating()
        guard let imageData = viewModel.profilePictureDataImage else { return }
        self.profilePictureImage.image = UIImage(data: imageData)
    }
    
    func retrieveUserInformation() {
        self.firstNameLabel.setTitle(viewModel.retrieveFirstName, for: .normal)
        self.lastNameLabel.setTitle(viewModel.retrieveLastName, for: .normal)
        self.defaultCurrencyPickerViewButton.setTitle(viewModel.retrieveDefaultCurrency, for: .normal)
        genderSegmentedControl.selectedSegmentIndex = viewModel.retrieveGender
        measurementUnitSegmentedControl.selectedSegmentIndex = viewModel.retrieveUnitMeasurement
        datePicker.setDate(viewModel.retrieveBirthDate, animated: true)
    }
}

extension SettingsViewController {
    
    private func setupDefaultCurrencyPickerAlert(for pickerViewController: UIViewController, with pickerView: UIPickerView) {
        let alert = UIAlertController(title: "Select Currency",
                                      message: "",
                                      preferredStyle: .actionSheet)
        
        alert.popoverPresentationController?.sourceView = defaultCurrencyPickerViewButton
        alert.popoverPresentationController?.sourceRect = defaultCurrencyPickerViewButton.bounds
        
        alert.setValue(pickerViewController, forKeyPath: "contentViewController")
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Select", style: .default, handler: { (_) in
            self.viewModel.selectedRow = pickerView.selectedRow(inComponent: 0)
            let selected = self.viewModel.currencyList[self.viewModel.selectedRow]
            let newDefaultCurrency = selected
            self.defaultCurrencyPickerViewButton.setTitle(newDefaultCurrency, for: .normal)
            self.viewModel.updateDefaultCurrency(newDefaultCurrency)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
