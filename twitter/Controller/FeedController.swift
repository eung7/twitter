//
//  FeedController.swift
//  twitter
//
//  Created by 김응철 on 2022/05/28.
//

import UIKit
import SnapKit
import Kingfisher

private let reuseIdentifier = "TweetCell"

class FeedController: UICollectionViewController {
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
        fetchTweets()
    }
    
    // MARK: - API
    func fetchTweets() {
        TweetService.shared.fetchTweets { tweets in
            print(tweets)
        }
    }
    
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .systemBackground
        
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .white

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

extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? TweetCell else { return UICollectionViewCell() }
        return cell
    }
}

extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
}
