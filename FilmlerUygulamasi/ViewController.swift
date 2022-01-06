//
//  ViewController.swift
//  FilmlerUygulamasi
//
//  Created by Kasım Adalan on 30.07.2019.
//  Copyright © 2019 info. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var kategoriTableView: UITableView!
    
    var kategorilerListe = [Kategoriler]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kategoriTableView.delegate = self
        kategoriTableView.dataSource = self
        
        tumKategorilerAl()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFilm"
        {
            let indeks = sender as? Int
            let gidilecekVC = segue.destination as! FilmViewController
            
            gidilecekVC.kategori = kategorilerListe[indeks!]
        }
    }
    func tumKategorilerAl()
    {
        let url = URL(string: "http://kasimadalan.pe.hu/filmler/tum_kategoriler.php")!
        
        URLSession.shared.dataTask(with: url) { data, response , error in
            print("dataexist1")
            if error != nil || data == nil
            {
                print("Hata")
                return
            }
            do {
                let cevap = try JSONDecoder().decode(KategoriCevap.self, from: data!)
                print("dataexist")
                if let gelenKategoriListesi = cevap.kategoriler
                {
                    self.kategorilerListe = gelenKategoriListesi
                    
                }
                DispatchQueue.main.async {
                    self.kategoriTableView.reloadData()
                }
                
            } catch  {
                print(error.localizedDescription)
            }
        }.resume()
        print("hata2")
    }


}

extension ViewController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kategorilerListe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let kategori = kategorilerListe[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "kategoriHucre", for: indexPath) as! KategoriHucreTableViewCell
        
        cell.labelKategoriAd.text = kategori.kategori_ad
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toFilm", sender: indexPath.row)
    }
}
