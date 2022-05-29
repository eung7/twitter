//
//  RegistrationController.swift
//  twitter
//
//  Created by 김응철 on 2022/05/28.
//

import UIKit
import SnapKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class RegistrationController: UIViewController {
    // MARK: - Properties
    var profileImage: UIImage?
    
    lazy var imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        return picker
    }()
    
    lazy var plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleAppProfilePhoto), for: .touchUpInside)
        return button
    }()
    
    lazy var alreadyHaveAccountButton: UIButton = {
        let button = Utilities.attributedButton("Already have an account?", " Sign Up")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    lazy var registrationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Registration", for: .normal)
        button.setTitleColor(UIColor.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5.0
        button.titleLabel?.font = .systemFont(ofSize: 20.0, weight: .bold)
        button.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        button.snp.makeConstraints { $0.height.equalTo(50.0) }
        return button
    }()
    
    lazy var emailContainerView: UIView = {
        let view = Utilities.inputContainerView(
            with: UIImage(named: "ic_mail_outline_white_2x-1"),
            textField: emailTextField
        )
        return view
    }()
    
    lazy var passwordContainerView: UIView = {
        let view = Utilities.inputContainerView(
            with: UIImage(named: "ic_lock_outline_white_2x"),
            textField: passwordTextField
        )
        return view
    }()
    
    lazy var fullnameContainerView: UIView = {
        let view = Utilities.inputContainerView(
            with: UIImage(named: "ic_mail_outline_white_2x-1"),
            textField: fullnameTextField
        )
        return view
    }()
    
    lazy var usernameContainerView: UIView = {
        let view = Utilities.inputContainerView(
            with: UIImage(named: "ic_lock_outline_white_2x"),
            textField: usernameTextField
        )
        return view
    }()
    
    let emailTextField: UITextField = {
        let tf = Utilities.textField(withPlaceholder: "Email")
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = Utilities.textField(withPlaceholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let fullnameTextField: UITextField = {
        let tf = Utilities.textField(withPlaceholder: "Full Name")
        return tf
    }()
    
    let usernameTextField: UITextField = {
        let tf = Utilities.textField(withPlaceholder: "Username")
        return tf
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleAppProfilePhoto() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func handleRegistration() {
        guard let profileImage = profileImage else {
            print("Please select a profile Image..."); return
        }
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let fullname = fullnameTextField.text,
              let username = usernameTextField.text else { return }
        let credentials = AuthCredentials(email: email, password: password, fullname: fullname, username: username, profileImage: profileImage)
        AuthService.shared.registerUser(credentials: credentials) { error, ref in
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .twitterBlue
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        
        [ emailContainerView, passwordContainerView, fullnameContainerView, usernameContainerView, registrationButton ]
            .forEach{ stack.addArrangedSubview($0) }
        
        [ alreadyHaveAccountButton, plusPhotoButton, stack ]
            .forEach { view.addSubview($0) }
        
        plusPhotoButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(128.0)
        }
        
        alreadyHaveAccountButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.trailing.leading.equalToSuperview().inset(40)
        }
        
        stack.snp.makeConstraints { make in
            make.top.equalTo(plusPhotoButton.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(32)
        }
    }
}

// MARK: - UIImagePickerControllerDelegate
extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        self.profileImage = profileImage
        plusPhotoButton.layer.cornerRadius = 128 / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.imageView?.contentMode = .scaleAspectFill
        plusPhotoButton.imageView?.clipsToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 3
        plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        dismiss(animated: true)
    }
}
