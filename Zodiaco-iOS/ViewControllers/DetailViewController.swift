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
    @IBOutlet weak var favoriteButtonItem: UIBarButtonItem!
    
    // MARK: Properties
    
    var horoscope: Horoscope!
    
    var session: SessionManager = SessionManager()
    
    var isFavorite: Bool = false
    
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
        
        isFavorite = session.isFavorite(id: horoscope.id)
        setFavoriteIcon()
    }
    
    func setFavoriteIcon() {
        if isFavorite {
            favoriteButtonItem.image = UIImage(systemName: "heart.fill")
        } else {
            favoriteButtonItem.image = UIImage(systemName: "heart")
        }
    }
    
    @IBAction func setFavorite(_ sender: Any) {
        isFavorite = !isFavorite
        if isFavorite {
            session.setFavorite(id: horoscope.id)
        } else {
            session.setFavorite(id: "")
        }
        setFavoriteIcon()
    }
    
    @IBAction func share(_ sender: Any) {
        // text to share
        let text = "This is some text that I want to share."
        
        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
}
