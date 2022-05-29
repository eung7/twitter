//
//  UploadTweetController.swift
//  twitter
//
//  Created by 김응철 on 2022/05/29.
//

import UIKit
import SnapKit

class UploadTweetController: UIViewController {
    // MARK: - Properties
    private let user: User
    let captionTextView = CaptionTextView()
    
    lazy var tweetButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .twitterBlue
        button.setTitle("Tweet", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .bold)
        button.layer.cornerRadius = 32 / 2
        button.snp.makeConstraints { $0.height.equalTo(32); $0.width.equalTo(64) }
        button.addTarget(self, action: #selector(handleUploadTweet), for: .touchUpInside)
       
        return button
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
    
    // MARK: - LifeCycle
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    @objc func handleCancel() {
        dismiss(animated: true)
    }

    @objc func handleUploadTweet() {
        guard let caption = captionTextView.text else { return }
        TweetService.shared.uploadTweet(caption: caption) { error, ref in
            if let error = error {
                print("DEBUG : Failed to upload tweet with error \(error.localizedDescription)")
            }
            self.dismiss(animated: true)
        }
    }
    
    // MARK: - API
    
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .white
        configureNavigationBar()
        
        let stack = UIStackView(arrangedSubviews: [ profileImageView, captionTextView ])
        stack.axis = .horizontal
        stack.spacing = 12
        
        profileImageView.kf.setImage(with: user.profileImageURL)
        profileImageView.contentMode = .scaleAspectFill

        [ stack ].forEach { view.addSubview($0) }
        
        stack.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.trailing.leading.equalToSuperview().inset(16)
        }
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: tweetButton)
    }
}
