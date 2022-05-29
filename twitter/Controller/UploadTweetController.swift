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
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    @objc func handleCancel() {
        dismiss(animated: true)
    }
    
    @objc func handleUploadTweet() {
        print("ddd")
    }
    
    // MARK: - API
    
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: tweetButton)
    }
}
