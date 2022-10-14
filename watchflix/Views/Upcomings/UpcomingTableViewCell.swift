//
//  UpcomingTableViewCell.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 25.09.2022.
//

import UIKit
import SnapKit

class UpcomingTableViewCell: UITableViewCell {
    
    static let identifier = "UpcomingTableViewCell"
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
        
    }()
    
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    private let movieOverview: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .thin)
        label.textColor = .label
        label.numberOfLines = 7
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: nil)
        contentView.addSubview(movieImageView)
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(movieOverview)
        contentView.addSubview(dateLabel)
            constraintSubViews()
    }
    

     func constraintSubViews() {
         movieImageView.snp.makeConstraints { make in
             make.top.equalToSuperview()
             make.leading.equalToSuperview().offset(5)
             make.width.equalTo(160)
             make.height.equalToSuperview().offset(-10)
         }
         movieTitleLabel.snp.makeConstraints { make in
             make.top.equalToSuperview().offset(5)
             make.leading.equalTo(movieImageView.snp.trailing).offset(5)
             make.trailing.equalToSuperview()


         }
         dateLabel.snp.makeConstraints { make in
             make.top.equalTo(movieTitleLabel.snp.bottom).offset(5)
             make.leading.equalTo(movieImageView.snp.trailing).offset(5)
             make.trailing.equalToSuperview()
         }
         movieOverview.snp.makeConstraints { make in
             make.top.equalTo(dateLabel.snp.bottom).offset(5)
             make.leading.equalTo(movieImageView.snp.trailing).offset(5)
             make.trailing.equalToSuperview()
         }
    }
    
    
    func configure(with model: UpcomingsPresentation) {
        movieImageView.sd_setImage(with: URL(string: APIConstants.baseImageURL + model.movieImage))
        movieTitleLabel.text = model.title
        movieOverview.text   = model.overview
        dateLabel.text       =  model.releaseDate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
