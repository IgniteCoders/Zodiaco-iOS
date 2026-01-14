//
//  ViewController.swift
//  Zodiaco-iOS
//
//  Created by Tardes on 14/1/26.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for item in Horoscope.horoscopeList {
            var icon = item.getIcon()
            if icon == nil {
                print("El horoscopo: \(item.name) no tiene icono")
            } else {
                print("El horoscopo: \(item.name) si tiene icono")
            }
        }

    }


}

