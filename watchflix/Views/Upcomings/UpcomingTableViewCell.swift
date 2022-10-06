//
//  UpcomingTableViewCell.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 25.09.2022.
//

import UIKit

class UpcomingTableViewCell: UITableViewCell {
    
    static let identifier = "UpcomingTableViewCell"
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
        
    }()
    
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    private let movieOverview: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .thin)
        label.textColor = .label
        label.numberOfLines = 3
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: nil)
        contentView.addSubview(movieImageView)
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(movieOverview)
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))

        movieImageView.frame = CGRect(
            x: 0, y: 0,
            width: contentView.heigth,
            height: contentView.heigth)
        
        movieTitleLabel.frame = CGRect(
            x: movieImageView.rigth + 5, y: 0,
            width: contentView.width - movieImageView.width - 4, height: 40)
        
        movieOverview.frame = CGRect(
            x: movieImageView.rigth + 5,
            y: movieTitleLabel.bottom,
            width: contentView.width - movieImageView.width - 4, height: contentView.heigth - movieTitleLabel.heigth)
    }
    
    
    func configure(with viewModel: UpcomingsPresentation) {
        
        movieTitleLabel.text = viewModel.title
        movieOverview.text = viewModel.overview
        
        movieImageView.sd_setImage(with: URL(string: APIConstants.BASE_IMAGE_URL + viewModel.movieImage))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
