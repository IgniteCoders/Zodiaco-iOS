//
//  DetailViewController.swift
//  Zodiaco-iOS
//
//  Created by Tardes on 15/1/26.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    // MARK: Properties
    
    var horoscope: Horoscope!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationItem.title = horoscope.name
        if #available(iOS 26.0, *) {
            navigationItem.subtitle = horoscope.dates
        } else {
            // Fallback on earlier versions
        }
        iconImageView.image = horoscope.getIcon()
    }
    
}
