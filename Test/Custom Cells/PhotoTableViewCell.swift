//
//  PhotoTableViewCell.swift
//  Test
//
//  Created by Alikhan Nursapayev on 26.04.2022.
//

import UIKit
import SDWebImage
class PhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    static let cellIdentifier: String = "PhotoTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() ->UINib {
        return UINib(nibName: "PhotoTableViewCell", bundle: nil)
    }
    
    public func configure(with viewModel: PhotosCellViewModel) {
        nameLabel.text = "\(viewModel.title)"
        if let imageUrl = URL(string: viewModel.img) {
            let scale = UIScreen.main.scale
            let thumbnailSize = CGSize(width: 200 * scale, height: 200 * scale)
                img.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "placeholder"), context: [.imageThumbnailPixelSize : thumbnailSize])

        }
    }
    
    
}
