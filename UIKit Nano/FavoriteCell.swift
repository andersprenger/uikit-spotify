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
    
    var service:MusicService?
    var music:Music?
    
    //var buttonFill: Bool = false
    
    @IBAction func favoriteButton(_ sender: UIButton) {
        // FIXME: implement me...
        
        let isFavorite = service?.favoriteMusics.contains(music!)
        
        if isFavorite! { // se for favorito, eu quero que ele n seja mais...
            service?.toggleFavorite(music: music!, isFavorite: false)
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        } else { // se n for, eu quero q seja
            service?.toggleFavorite(music: music!, isFavorite: true)
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        
        print(service?.favoriteMusics)
        
        //service?.toggleFavorite(music: music!, isFavorite: !(service?.favoriteMusics.contains(music!))!)
//        if buttonFill == true {
//            service?.toggleFavorite(music: music!, isFavorite: buttonFill)
//            buttonFill.toggle()
//        }
//        else {
//            service?.toggleFavorite(music: music!, isFavorite: buttonFill)
//            buttonFill.toggle()
//            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//        }
        
        
        
    }
}
