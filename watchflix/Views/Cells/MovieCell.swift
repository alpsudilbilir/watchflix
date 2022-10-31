//
//  MovieCollectionViewCell.swift
//  netflix-clone
//
//  Created by Alpsu Dilbilir on 6.09.2022.
//

import UIKit
import SDWebImage

class MovieCell: UICollectionViewCell {
    
    static let identifier      = "MovieCell"
    
    private let movieImageView = WFImageView(cornerRadius: 8, border: false, contentMode: .scaleToFill)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(movieImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        movieImageView.frame = contentView.bounds
    }
    
    func configure(with model: MoviePresentation) {
        movieImageView.sd_setImage(with: URL(string: APIConstants.baseImageURL + model.movieImage))
    }
}
