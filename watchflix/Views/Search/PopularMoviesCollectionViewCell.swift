//
//  PopularMoviesCollectionViewCell.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 12.10.2022.
//

import UIKit

class PopularMoviesCollectionViewCell: UICollectionViewCell {
    static let identifier = "PopularMoviesCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    func configure(with model: Movie) {
        imageView.sd_setImage(with: URL(string: APIConstants.BASE_IMAGE_URL + (model.poster_path ?? "-") ))
    }
    
}
