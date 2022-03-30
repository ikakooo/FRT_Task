//
//  RepositoryCell.swift
//  FRT_Task
//
//  Created by Irakli Chkhitunidzde on 30.03.22.
//

import UIKit
import Kingfisher

class RepositoryCell: UITableViewCell {
    @IBOutlet weak var avatarIMG: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var repositoryNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with:Item){
        nameLabel.text = with.owner?.login
        repositoryNameLabel.text = with.name
        avatarIMG.kf.setImage(with: URL(string: with.owner?.avatarURL ?? ""))
    }
    
}
