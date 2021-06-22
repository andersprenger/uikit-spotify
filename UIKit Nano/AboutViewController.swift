//
//  AboutViewController.swift
//  UIKit Nano
//
//  Created by Willian Magnum Albeche on 22/06/21.
//

import UIKit

class AboutViewController: UIViewController {
    
    
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!// data, songs number and artist
    
    @IBOutlet weak var albumDescription: UILabel!
    @IBOutlet weak var autorNameLabel: UILabel!
    
    @IBOutlet weak var autorDescriptionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    //fazer divider entre as labels de texto grandao

    @IBAction func buttonViewDown(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
}
