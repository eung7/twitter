//
//   TweetCell.swift
//  twitter
//
//  Created by 김응철 on 2022/05/29.
//

import UIKit
import SnapKit

class TweetCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .twitterBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
