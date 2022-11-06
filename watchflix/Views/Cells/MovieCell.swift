//
//  MovieCollectionViewCell.swift
//  netflix-clone
//
//  Created by Alpsu Dilbilir on 6.09.2022.
//

import UIKit
import SDWebImage
import SnapKit

class MovieCell: UICollectionViewCell {
    
    static let identifier      = "MovieCell"
    private let movieImageView = WFImageView(cornerRadius: 8, border: false, contentMode: .scaleToFill)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(movieImageView)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutUI() {
        movieImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(with model: MoviePresentation) {
        movieImageView.sd_setImage(with: URL(string: APIConstants.baseImageURL + model.movieImage))
    }
}
