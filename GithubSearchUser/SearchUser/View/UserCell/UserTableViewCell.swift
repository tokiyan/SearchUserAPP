//
//  UserTableViewCell.swift
//  GithubSearchUser
//
//  Created by TOKIYA on 2020/04/18.
//  Copyright © 2020 TOKIYA. All rights reserved.
//

import UIKit
import Kingfisher

final class UserTableViewCell: UITableViewCell {

    @IBOutlet private weak var userImage: UIImageView!
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(_ data: User) {
        let url = URL(string: data.avatarURL)
        userImage.kf.setImage(with: url)
        nameLabel.text = data.login
        typeLabel.text = data.type
    }
}
