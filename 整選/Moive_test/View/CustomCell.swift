//
//  CustomCell.swift
//  Moive_test
//
//  Created by 陳冠雄 on 2021/5/5.
//

import Foundation
import UIKit
class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var Label: UILabel!
    
    
}
class MainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieCollectionViewCellCover: UIImageView!
}


class FavoriteMovieCell: UITableViewCell {
    
    @IBOutlet weak var movieCover: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
}
