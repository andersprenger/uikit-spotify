//
//  FavoriteTableViewCell.swift
//  UIKit Nano
//
//  Created by Willian Magnum Albeche on 22/06/21.
//

import UIKit

class FavoriteCell: UITableViewCell {

    
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var labelTitleCell: UILabel!
    @IBOutlet weak var labelSubtitleCell: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    @IBAction func favoriteButton(_ sender: UIButton) {
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
