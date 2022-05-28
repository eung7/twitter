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
     
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.barStyle = .black
        
        let stack = UIStackView(arrangedSubviews: [ emailContainerView, passwordContainerView ])
        stack.axis = .vertical
        stack.spacing = 8
        
        [ logoImageView, stack ]
            .forEach { view.addSubview($0) }
        
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.width.equalTo(150)
        }
        
        stack.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
    }
}
