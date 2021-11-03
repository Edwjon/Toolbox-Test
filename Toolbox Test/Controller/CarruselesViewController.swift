//
//  CarruselesViewController.swift
//  Toolbox Test
//
//  Created by Edward Pizzurro Fortun on 3/11/21.
//

import UIKit
import AVKit
import AVFoundation

private let reuseIdentifier = "Cell"
var counter = 0
var carruseles = [CarruselesData]()

class CarruselesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    
    private let cache = NSCache<NSNumber, UIImage>()
    private let utilityQueue = DispatchQueue.global(qos: .utility)
    
    
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionView2: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}


//MARK: - UI -
extension CarruselesViewController {
    
    func setupUI() {
        tituloLabel.text = carruseles[counter].title

        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView2.delegate = self
        collectionView2.dataSource = self
        
        self.collectionView!.register(CarruselCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView2!.register(CarruselCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width*0.8)
        let cellHeight = floor(screenSize.height*0.8)
        let insetX = (view.bounds.width - cellWidth) / 2
        let insetY = (view.bounds.height - cellHeight) / 2
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        collectionView.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
    }
}


//MARK: - IBActions -
extension CarruselesViewController {
    
    @IBAction func nextAction(_ sender: Any) {
        
        if (counter + 1 == carruseles.count) {
            //No hay más elementos
            counter = 0
            self.performSegue(withIdentifier: "goCarruseles2", sender: nil)
        } else {
            //Aun quedan elementos
            counter = counter + 1
            self.performSegue(withIdentifier: "goCarruseles2", sender: nil)
        }
    }
}


//MARK: - CollectionView Methods -
extension CarruselesViewController {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return carruseles[counter].items.count
        
    }
    
    private func loadImage(indice: Int,completion: @escaping (UIImage?) -> ()) {
        utilityQueue.async {
            let url = URL(string: carruseles[counter].items[indice].imageUrl)!
            
            guard let data = try? Data(contentsOf: url) else { return }
            let image = UIImage(data: data)
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CarruselCell
    
        cell.titleLabel.text = carruseles[counter].items[indexPath.item].title
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            
            
            guard let cell = cell as? CarruselCell else { return }
            let itemNumber = NSNumber(value: indexPath.item)
            
            if let cachedImage = self.cache.object(forKey: itemNumber) {
                cell.imageView.image = cachedImage
            } else {
                self.loadImage(indice: indexPath.item) { [weak self] (image) in
                    
                    guard let self = self, let image = image else { return }
                    cell.imageView.image = image
                    self.cache.setObject(image, forKey: itemNumber)
                }
            }
        }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if carruseles[counter].type == "poster" {
            return CGSize(width: 250, height: 400)
        } else {
            return CGSize(width: 500, height: 350)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if carruseles[counter].items[indexPath.item].videoUrl != nil {
            
            let player = AVPlayer(url: URL(string: carruseles[counter].items[indexPath.item].videoUrl!)!)
            let vc = AVPlayerViewController()
            vc.player = player
            self.present(vc, animated: true) { vc.player?.play() }
            
        } else {
            let alertController = UIAlertController(title: "Alerta", message: "El video no ha sido encontrado...", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }

}
