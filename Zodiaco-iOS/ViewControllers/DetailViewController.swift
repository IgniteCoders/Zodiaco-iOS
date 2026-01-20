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
    @IBOutlet weak var predictionTextView: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Properties
    
    var horoscope: Horoscope!
    
    var session: SessionManager = SessionManager()
    
    var isFavorite: Bool = false
    
    var prediction: String? = nil
    
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
        
        getHoroscopePrediction()
    }
    
    func setFavoriteIcon() {
        if isFavorite {
            favoriteButtonItem.image = UIImage(systemName: "heart.fill")
        } else {
            favoriteButtonItem.image = UIImage(systemName: "heart")
        }
    }
    
    // MARK: Actions
    
    @IBAction func didChangePeriod(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            getHoroscopePrediction(period: "daily")
        case 1:
            getHoroscopePrediction(period: "weekly")
        default:
            getHoroscopePrediction(period: "monthly")
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
        if let prediction = prediction {
            // text to share
            let text = "Mira mi predicción para \(horoscope.name): \(prediction)"
            
            // set up activity view controller
            let textToShare = [ text ]
            let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
            
            // present the view controller
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    func getHoroscopePrediction(period: String = "daily") {
        activityIndicator.isHidden = false
        self.predictionTextView.text = "Consultando con las estrellas..."
        
        let url = URL(string: "https://horoscope-app-api.vercel.app/api/v1/get-horoscope/\(period)?sign=\(horoscope.id)&day=TODAY")
        
        guard let url = url else {
            print("Invalid URL")
            return
        }
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                /*if let str = String(data: data, encoding: .utf8) {
                    print("Successfully decoded: \(str)")
                }*/
                
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let jsonObjectData = jsonObject["data"] as! [String: String]
                let result = jsonObjectData["horoscope_data"]!
                
                prediction = result
                
                DispatchQueue.main.async {
                    // Mostrar el resultado en pantalla
                    self.predictionTextView.text = result
                    self.activityIndicator.isHidden = true
                }
            } catch {
                print("Invalid data")
                DispatchQueue.main.async {
                    // Mostrar el resultado en pantalla
                    self.predictionTextView.text = "Hubo un error inesperado. Inténtalo más tarde."
                    self.activityIndicator.isHidden = true
                }
            }
        }
    }
}
