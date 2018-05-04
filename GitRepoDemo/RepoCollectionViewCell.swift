//
//  RepoCollectionViewCell.swift
//  GitRepoDemo
//
//  Created by Manikanta Nallabelly on 5/3/18.
//  Copyright © 2018 Akvelon. All rights reserved.
//

import UIKit

class RepoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var licenseLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.textColor = UIColor(red: 43.0/255.0, green: 58.0/255.0, blue: 66.0/255.0, alpha: 1.0)
        descriptionLabel.textColor = UIColor(red: 63.0/255.0, green: 87.0/255.0, blue: 101.0/255.0, alpha: 1.0)
    }
    
    func configure(with repo: Repo) {
        nameLabel.text = repo.name
        descriptionLabel.text = repo.description
        createdAtLabel.text = repo.created_at
        licenseLabel.text = repo.license?.name
    }
}
