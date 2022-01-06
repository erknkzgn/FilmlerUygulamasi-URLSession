//
//  FilmDetayViewController.swift
//  FilmlerUygulamasi
//
//  Created by Kasım Adalan on 30.07.2019.
//  Copyright © 2019 info. All rights reserved.
//

import UIKit

class FilmDetayViewController: UIViewController {
    @IBOutlet weak var imageViewFilmResim: UIImageView!
    
    @IBOutlet weak var labelFilmAd: UILabel!
    @IBOutlet weak var labelFilmYil: UILabel!
    @IBOutlet weak var labelFilmKategori: UILabel!
    @IBOutlet weak var labelFilmYonetmen: UILabel!
    
    var film:Filmler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let film = film
        {
            if let url = URL(string: "http://kasimadalan.pe.hu/filmler/resimler/\(film.film_resim!)")
            {
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url)
                    
                    DispatchQueue.main.async {
                        self.imageViewFilmResim.image = UIImage(data: data!)
                    }
                }
            }
            labelFilmAd.text = film.film_ad
            labelFilmYil.text = film.film_yil
            labelFilmKategori.text = film.kategori?.kategori_ad
            labelFilmYonetmen.text = film.yonetmen?.yonetmen_ad
        }
        // Do any additional setup after loading the view.
    }

}
