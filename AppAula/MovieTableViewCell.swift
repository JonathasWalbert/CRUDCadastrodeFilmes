//
//  MovieTableViewCell.swift
//  AppAula
//
//  Created by jonathas on 22/07/22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSummary: UILabel!
    @IBOutlet weak var labelRating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureWith(_ movie: Movie){
        
        if let image = movie.image {
            imageViewPoster.image = UIImage(data: image)
        }
        labelTitle.text = movie.title
        labelSummary.text = movie.summary
        labelRating.text = "⭐️ \(movie.rating)"
    }
    

}
