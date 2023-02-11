//
//  MovieCollectionViewCell.swift
//  Movies PlayList
//
//  Created by Mina on 05/02/2023.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgPhotos: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    
    
    func configure(with model: Item){
        lblTitle.text = model.title
        let url = model.image!
        if let data = try? Data(contentsOf: URL(string: url)!) {
            self.imgPhotos.image = UIImage(data: data)
        }
        
    }
    /*func configure(with model: Movie){
        self.movieTitleLabel.text = model.Title
        self.movieYearLabel.text = model.Year
        let url = model.Poster
        if let data = try? Data(contentsOf: URL(string: url)!) {
            self.moviePosterLabel.image = UIImage(data: data)
        }
        
    }*/
    
    
    
    
}
