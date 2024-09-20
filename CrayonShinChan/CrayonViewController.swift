//
//  CrayonViewController.swift
//  CrayonShinChan
//
//  Created by Adam Chen on 2024/9/19.
//

import UIKit


class CrayonViewController: UIViewController {

    //let movieArray = (0...11).map { Movie(name: "蠟筆小新\($0)", image: "pic\($0)") }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension CrayonViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CrayonCollectionViewCell.reuseIdentifier, for: indexPath) as! CrayonCollectionViewCell
        let movie = movies[indexPath.item]
        cell.movieImageView.image = UIImage(named: movie.image)
        cell.movieNameLabel.text = movie.name
        return cell
    }
    
    
}
