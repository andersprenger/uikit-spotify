//
//  AboutViewController.swift
//  UIKit Nano
//
//  Created by Willian Magnum Albeche on 22/06/21.
//

import UIKit

class AboutViewController: UIViewController {
    
    var reciver:MusicCollection?
    var service:MusicService?
    
    @IBOutlet weak var albumImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var aboutAlbumLabel: UILabel!
    
    @IBOutlet weak var aboutArtistTitleLabel: UIStackView!
    @IBOutlet weak var aboutArtistLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        albumImage.image =  service?.getCoverImage(forItemIded: reciver!.id)
        titleLabel.text = reciver?.title
        
        // MARK: -- explicando o reduce...
        // reduce eh basicamente um for com bastante açucar sintatico
        // para cada music em reciver?.musics
        // some a result (iniciado com 0 no parametro) music.length
        // como a soma retorna um Double, e TimeInterval eh um type alias pra Double, funciona.
        
        let sum: TimeInterval? = reciver?.musics.reduce(0) { result, music in
            result + music.length
        }

        // MARK: -- formatter pro TimeInterval virar uma String quase como esta no figma
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated // pra ficar igual tem que mudar alguma coisa aqui
        
        detailsLabel.text = "\(reciver?.musics.count) songs, \(formatter.string(from: sum ?? 0))"
        aboutAlbumLabel.text = reciver?.albumDescription ?? "not an album, treat me 🩹"
        
        
    }
    
    
    
    //fazer divider entre as labels de texto grandao

    @IBAction func buttonViewDown(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
}
