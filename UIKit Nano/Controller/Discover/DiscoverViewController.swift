//
//  DiscoverViewController.swift
//  UIKit Nano
//
//  Created by RafaelAraujo on 22/09/21.
//

import UIKit

class DiscoverViewController: UIViewController {
    var service: MusicService!
    private var sections: [Discover.Section] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sections = Discover.buildMock(service: service)
    }
}
