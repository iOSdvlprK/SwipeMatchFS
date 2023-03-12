//
//  RegistrationController.swift
//  SwipeMatchFS
//
//  Created by joe on 2023/03/10.
//

import UIKit
import FirebaseAuth
import JGProgressHUD

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
//        registrationViewModel.image = image
        registrationViewModel.bindableImage.value = image
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}

class RegistrationController: UIViewController {
    
    // UI Components
    let selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Photo", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        button.backgroundColor = .systemBackground
        button.setTitleColor(.label, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 275).isActive = true
        button.layer.cornerRadius = 16
        button.addTarget(nil, action: #selector(handleSelectPhoto), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        return button
    }()
    
    @objc fileprivate func handleSelectPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true)
    }
    
    let fullNameTextField: CustomTextField = {
        let tf = CustomTextField(padding: 16)
        tf.placeholder = "Enter full name"
        tf.addTarget(nil, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    
    let emailTextField: CustomTextField = {
        let tf = CustomTextField(padding: 16)
        tf.placeholder = "Enter email"
        tf.keyboardType = .emailAddress
        tf.addTarget(nil, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    
    let passwordTextField: CustomTextField = {
        let tf = CustomTextField(padding: 16)
        tf.placeholder = "Enter password"
        tf.isSecureTextEntry = true
        tf.addTarget(nil, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    
    @objc fileprivate func handleTextChange(textField: UITextField) {
        if textField == fullNameTextField {
            registrationViewModel.fullName = textField.text
        } else if textField == emailTextField {
            registrationViewModel.email = textField.text
        } else {
            registrationViewModel.password = textField.text
        }
    }
    
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.systemBackground, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
//        button.backgroundColor = UIColor(red: 210/255, green: 0/255, blue: 83/255, alpha: 1)
        button.backgroundColor = .systemGray5
        button.setTitleColor(.systemGray2, for: .disabled)
        button.isEnabled = false
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.layer.cornerRadius = 22
        button.addTarget(nil, action: #selector(handleRegister), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func handleRegister() {
        self.handleTapDismiss()
        print("Register our User in Firebase Auth")
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { res, err in
            if let err = err {
                print(err)
                self.showHUDWithError(error: err)
                return
            }
            print("Successfully registered user:", res?.user.uid ?? "")
        }
    }
    
    fileprivate func showHUDWithError(error: Error) {
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Failed registration"
        hud.detailTextLabel.text = error.localizedDescription
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 4)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupGradientLayer()
        setupLayout()
        setupNotificationObservers()
        setupTapGesture()
        setupRegistrationViewModelObserver()
    }
    
    // MARK: - Private
    
    let registrationViewModel = RegistrationViewModel()
    
    fileprivate func setupRegistrationViewModelObserver() {
//        registrationViewModel.isFormValidObserver = { [unowned self] isFormValid in
//            print("Form is changing, is it valid?", isFormValid)
//
//            registerButton.isEnabled = isFormValid
//            if isFormValid {
//                registerButton.backgroundColor = UIColor(red: 210/255, green: 0/255, blue: 83/255, alpha: 1)
//                registerButton.setTitleColor(.systemBackground, for: .normal)
//            } else {
//                registerButton.backgroundColor = .systemGray5
//                registerButton.setTitleColor(.systemGray2, for: .normal)
//            }
//        }
        registrationViewModel.bindableIsFormValid.bind { [unowned self] isFormValid in
            guard let isFormValid = isFormValid else { return }
            registerButton.isEnabled = isFormValid
            if isFormValid {
                registerButton.backgroundColor = UIColor(red: 210/255, green: 0/255, blue: 83/255, alpha: 1)
                registerButton.setTitleColor(.systemBackground, for: .normal)
            } else {
                registerButton.backgroundColor = .systemGray5
                registerButton.setTitleColor(.systemGray2, for: .normal)
            }
        }
//        registrationViewModel.imageObserver = { [unowned self] img in
//            selectPhotoButton.setImage(img?.withRenderingMode(.alwaysOriginal), for: .normal)
//        }
        registrationViewModel.bindableImage.bind { [unowned self] img in
            selectPhotoButton.setImage(img?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    
    fileprivate func setupTapGesture() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
    }
    
    @objc fileprivate func handleTapDismiss() {
        self.view.endEditing(true)  // dismisses keyboard
    }
    
    fileprivate func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self) // otherwise, we'll have a retain cycle
    }
    
    @objc fileprivate func handleKeyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.view.transform = .identity
        }
    }
    
    @objc fileprivate func handleKeyboardShow(notification: Notification) {
        // how to figure out how tall the keyboard actually is
//        print(notification.userInfo)
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = value.cgRectValue
        print(keyboardFrame)
        
        // figure out how tall the gap is from the register button to the bottom of the screen
        let bottomSpace = view.frame.height - overallStackView.frame.origin.y - overallStackView.frame.height
        print(bottomSpace)
        
        let difference = keyboardFrame.height - bottomSpace
        self.view.transform = CGAffineTransform(translationX: 0, y: -difference - 8)
    }
    
    lazy var verticalStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            fullNameTextField,
            emailTextField,
            passwordTextField,
            registerButton
        ])
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.spacing = 8
        return sv
    }()
    
    lazy var overallStackView = UIStackView(arrangedSubviews: [
        selectPhotoButton,
        verticalStackView
    ])
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if self.traitCollection.verticalSizeClass == .compact {
            overallStackView.axis = .horizontal
        } else {
            overallStackView.axis = .vertical
        }
    }
    
    fileprivate func setupLayout() {
        view.addSubview(overallStackView)
        overallStackView.axis = .vertical
        selectPhotoButton.widthAnchor.constraint(equalToConstant: 275).isActive = true
        overallStackView.spacing = 8
        overallStackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50))
        overallStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    let gradientLayer = CAGradientLayer()
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradientLayer.frame = view.bounds
    }
    
    fileprivate func setupGradientLayer() {
        let topColor = UIColor(red: 253/255, green: 91/255, blue: 95/255, alpha: 1)
        let bottomColor = UIColor(red: 229/255, green: 0/255, blue: 114/255, alpha: 1)
        // make sure to user cgColor
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0, 1]
        view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = view.bounds
    }

}
