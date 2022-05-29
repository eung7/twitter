//
//  CaptionTextView.swift
//  twitter
//
//  Created by 김응철 on 2022/05/29.
//

import UIKit
import SnapKit

class CaptionTextView: UITextView {
    // MARK: - Properties
    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0)
        label.textColor = .darkGray
        label.text = "What's happening?"
        
        return label
    }()
    
    // MARK: - LifeCycle
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        backgroundColor = .white
        font = .systemFont(ofSize: 16.0)
        isScrollEnabled = false
        self.snp.makeConstraints { $0.height.equalTo(300) }
        
        addSubview(placeholderLabel)
        placeholderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8); make.leading.equalToSuperview().inset(4)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    @objc func handleTextInputChange() {
        placeholderLabel.isHidden = self.text.isEmpty ? false : true
    }
}
