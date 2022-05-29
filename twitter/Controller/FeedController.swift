//
//  FeedController.swift
//  twitter
//
//  Created by 김응철 on 2022/05/28.
//

import UIKit
import SnapKit
import Kingfisher

class FeedController: UIViewController {
    // MARK: - Properties
    var user: User? {
        didSet {
            configureLeftBarButton()
        }
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .systemBackground

        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.snp.makeConstraints { $0.height.width.equalTo(44) }
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
    
    func configureLeftBarButton() {
        guard let user = user else { return }
        let profileImageView = UIImageView()
        profileImageView.snp.makeConstraints { $0.height.width.equalTo(32) }
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = 32 / 2
        profileImageView.kf.setImage(with: user.profileImageURL)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
}
