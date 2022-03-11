//
//  MainListTableViewCell.swift
//  MARVEL_app
//
//  Created by Daniel Abad Jaraute on 10/03/2022.
//

import UIKit

class MainListTableViewCell: UITableViewCell {

    // MARK: Properties
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var imgThumbnail: UIImageView!
    @IBOutlet weak var vCard: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgThumbnail.layer.cornerRadius = 32
        self.imgThumbnail.layer.borderWidth = 1
        self.imgThumbnail.layer.borderColor = UIColor.black.cgColor
        vCard.backgroundColor = UIColor.init(rgb: Utils.MARVEL_COLORS.YELLOW.rawValue)
        vCard.layer.borderWidth = 1
        vCard.layer.cornerRadius = 6
        vCard.layer.borderColor = UIColor.gray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
