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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with:Item){
        nameLabel.text = with.owner?.login
        repositoryNameLabel.text = with.name
        //avatarIMG.kf.setImage(with: URL(string: with.owner?.avatarURL ?? ""))
        loadIMGFromInternet(ImgURL: with.owner?.avatarURL ?? "")
    }
    
    func loadIMGFromInternet(ImgURL:String){
        let url = URL(string: ImgURL)
        let processor = DownsamplingImageProcessor(size: avatarIMG.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 20)
        avatarIMG.kf.indicatorType = .activity
        avatarIMG.kf.setImage(
            with: url,
            placeholder: nil,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        { result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
    
}
