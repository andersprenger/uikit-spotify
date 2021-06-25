//
//  FavoriteTableViewCell.swift
//  UIKit Nano
//
//  Created by Willian Magnum Albeche on 22/06/21.
//

import UIKit

protocol FavoriteCellDelegate : AnyObject{
    func toggleFavorite(music:Music)
}

class FavoriteCell: UITableViewCell {
    
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var labelTitleCell: UILabel!
    @IBOutlet weak var labelSubtitleCell: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var service:MusicService?
    var music:Music?
    
    weak var delegate: FavoriteCellDelegate?
    
    @IBAction func favoriteButton(_ sender: UIButton) {
        let isFavorite = service?.favoriteMusics.contains(music!)
        
        if isFavorite! { // se for favorito, eu quero que ele n seja mais...
            service?.toggleFavorite(music: music!, isFavorite: false)
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            favoriteButton.tintColor = .black
        } else { // se n for, eu quero q seja
            service?.toggleFavorite(music: music!, isFavorite: true)
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            favoriteButton.tintColor = .red
        }
        
        delegate?.toggleFavorite(music: music!)
    }
}
