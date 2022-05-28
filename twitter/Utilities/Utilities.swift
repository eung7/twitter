//
//  Utilities.swift
//  twitter
//
//  Created by 김응철 on 2022/05/28.
//

import UIKit
import SnapKit

class Utilities {
    static func inputContainerView(with image: UIImage?, textField: UITextField) -> UIView {
        let view = UIView()
        let iv = UIImageView(); iv.image = image
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        
        [ iv, textField, dividerView ].forEach { view.addSubview($0) }
        
        view.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        iv.snp.makeConstraints {
            $0.bottom.leading.equalToSuperview().inset(8)
            $0.width.height.equalTo(24.0)
        }
        textField.snp.makeConstraints {
            $0.leading.equalTo(iv.snp.trailing).offset(8)
            $0.trailing.bottom.equalToSuperview().inset(8)
        }
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(8)
            make.trailing.leading.equalToSuperview().inset(8)
            make.height.equalTo(0.5)
        }
        
        return view
    }
    
    static func textField(withPlaceholder placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.placeholder = placeholder
        tf.textColor = .white
        tf.font = .systemFont(ofSize: 16.0)
        tf.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        
        return tf
    }
    
    static func attributedButton(_ firstPart: String, _ secondPart: String) -> UIButton {
        let button = UIButton()
        
        let attributedString = NSMutableAttributedString(string: firstPart, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0), NSAttributedString.Key.foregroundColor: UIColor.white])
        attributedString.append(NSAttributedString(string: secondPart, attributes: [NSMutableAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0, weight: .bold), NSAttributedString.Key.foregroundColor: UIColor.white]))
        button.setAttributedTitle(attributedString, for: .normal)
        
        return button
    }
}
