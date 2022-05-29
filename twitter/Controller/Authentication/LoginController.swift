//
//  LoginController.swift
//  twitter
//
//  Created by 김응철 on 2022/05/28.
//

import UIKit
import SnapKit

class LoginController: UIViewController {
    // MARK: - Properties
    let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = UIImage(named: "TwitterLogo")
        return iv
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
    
    let emailTextField: UITextField = {
        let tf = Utilities.textField(withPlaceholder: "Email")
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = Utilities.textField(withPlaceholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(UIColor.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5.0
        button.titleLabel?.font = .systemFont(ofSize: 20.0, weight: .bold)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.snp.makeConstraints { $0.height.equalTo(50.0) }
        return button
    }()
    
    lazy var dontHaveAccountButton: UIButton = {
        let button = Utilities.attributedButton("Don't have an account", " Sign Up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    @objc func handleLogin() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else { return }
        AuthService.shared.logUserIn(email: email, password: password) { result, error in
            if let error = error {
                print(error.localizedDescription); return
            }
            // TODO: [x] window이해하기
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene
            let window = windowScene?.windows.first
            guard let tab = window?.rootViewController as? MainTabController else { return }
            tab.authenticateUserAndConfigure()
            self.dismiss(animated: true)
        }
    }
    
    @objc func handleShowSignUp() {
        let vc = RegistrationController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        
        let stack = UIStackView(arrangedSubviews: [ emailContainerView, passwordContainerView, loginButton ])
        stack.axis = .vertical
        stack.spacing = 20
        
        [ logoImageView, stack, dontHaveAccountButton ]
            .forEach { view.addSubview($0) }
        
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.width.equalTo(150)
        }
        
        stack.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(32)
        }
        
        dontHaveAccountButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.trailing.leading.equalToSuperview().inset(40)
        }
    }
}
