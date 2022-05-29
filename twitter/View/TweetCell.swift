//
//   TweetCell.swift
//  twitter
//
//  Created by 김응철 on 2022/05/29.
//

import UIKit
import SnapKit

class TweetCell: UICollectionViewCell {
    // MARK: - Properties
    let infoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0)
        label.text = "kimEung @eung7"
        
        return label
    }()

    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.snp.makeConstraints { $0.height.equalTo(48); $0.width.equalTo(48) }
        iv.backgroundColor = .twitterBlue
        iv.layer.cornerRadius = 48 / 2
        
        return iv
    }()
    
    let captionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0)
        label.numberOfLines = 0
        label.text = "Some test caption"
        
        return label
    }()
    
    let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGroupedBackground
        
        return view
    }()
    
    lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "comment"), for: .normal)
        button.tintColor = .darkGray
        button.snp.makeConstraints { $0.height.width.equalTo(20) }
        button.addTarget(self, action: #selector(handleCommentTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var retweetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "retweet"), for: .normal)
        button.tintColor = .darkGray
        button.snp.makeConstraints { $0.height.width.equalTo(20) }
        button.addTarget(self, action: #selector(handleRetweetTapped), for: .touchUpInside)
        
        return button
    }()

    lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "like"), for: .normal)
        button.tintColor = .darkGray
        button.snp.makeConstraints { $0.height.width.equalTo(20) }
        button.addTarget(self, action: #selector(handleLikeTapped), for: .touchUpInside)
        
        return button
    }()

    lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "share"), for: .normal)
        button.tintColor = .darkGray
        button.snp.makeConstraints { $0.height.width.equalTo(20) }
        button.addTarget(self, action: #selector(handleShareTapped), for: .touchUpInside)
        
        return button
    }()


    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        let stack = UIStackView(arrangedSubviews: [ infoLabel, captionLabel ])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 4
        
        let actionStack = UIStackView(arrangedSubviews: [ commentButton, retweetButton, likeButton, shareButton])
        actionStack.axis = .horizontal
        actionStack.distribution = .equalSpacing

        [ profileImageView, stack, underlineView, actionStack ]
            .forEach { contentView.addSubview($0) }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(8)
        }
        
        stack.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.top)
            make.leading.equalTo(profileImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(12)
        }
        
        underlineView.snp.makeConstraints { make in
            make.right.bottom.leading.equalToSuperview()
            make.height.equalTo(1)
        }
        
        actionStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(52)
            make.bottom.equalToSuperview().inset(8)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    @objc func handleCommentTapped() {
        
    }
    
    @objc func handleRetweetTapped() {
        
    }

    @objc func handleLikeTapped() {
        
    }

    @objc func handleShareTapped() {
        
    }

    
    // MARK: - Helpers
}
