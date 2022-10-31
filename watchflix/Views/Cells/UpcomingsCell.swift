//
//  UpcomingTableViewCell.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 25.09.2022.
//

import UIKit
import SnapKit

class UpcomingsCell: UITableViewCell {
    
    static let identifier = "UpcomingTableViewCell"
    
    private let movieImageView       = WFImageView(cornerRadius: 10, border: false, contentMode: .scaleAspectFill)
    private let movieTitleLabel      = WFTitleLabel()
    private let dateLabel            = WFLabel(fontSize: 18, weight: .regular, textAlignment: .natural)
    private let movieOverviewLabel   = WFLabel(fontSize: 16, weight: .light, textAlignment: .natural)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: nil)
        contentView.addSubview(movieImageView)
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(movieOverviewLabel)
        contentView.addSubview(dateLabel)
            constraintSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
             make.top.equalTo(movieTitleLabel.snp.bottom).offset(2)
             make.leading.equalTo(movieImageView.snp.trailing).offset(5)
             make.trailing.equalToSuperview().offset(5)
             make.height.equalTo(20)
         }
         movieOverviewLabel.snp.makeConstraints { make in
             make.top.equalTo(dateLabel.snp.bottom).offset(5)
             make.leading.equalTo(movieImageView.snp.trailing).offset(5)
             make.trailing.equalToSuperview().offset(-5)
             make.bottom.equalToSuperview().offset(-5)
         }
    }
    
    func configure(with model: UpcomingsPresentation) {
        movieImageView.sd_setImage(with: URL(string: APIConstants.baseImageURL + model.movieImage))
        movieTitleLabel.text    = model.title
        movieOverviewLabel.text = model.overview
        dateLabel.text          = model.releaseDate
    }
   
}
