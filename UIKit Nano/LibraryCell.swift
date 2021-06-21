//
//  LibraryCell.swift
//  UIKit Nano
//
//  Created by Anderson Sprenger on 21/06/21.
//

import UIKit

class LibraryCell: UITableViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellDetails: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
