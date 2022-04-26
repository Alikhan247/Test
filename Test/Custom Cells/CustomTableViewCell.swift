//
//  CustomTableViewCell.swift
//  Test
//
//  Created by Alikhan Nursapayev on 26.04.2022.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    
    static let cellIdentifier: String = "CustomTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    static func nib() ->UINib {
        return UINib(nibName: "CustomTableViewCell", bundle: nil)
    }
    
    public func configure(with viewModel: CellViewModel) {
        nameLabel.text = "\(viewModel.title)"
    }
    
}
