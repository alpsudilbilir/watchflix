//
//  ResultsTableViewCell.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 12.10.2022.
//

import UIKit
import SnapKit
import SDWebImage
class ResultsTableViewCell: UITableViewCell {
    static let identifier = "ResultsTableViewCell"
    private var mediaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.layer.shadowRadius = 100
        imageView.layer.shadowColor = UIColor.systemYellow.cgColor
        return imageView
    }()
    private let playSymbol: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 20)))
        imageView.tintColor = .label
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    private let mediaTypeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(mediaImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(mediaTypeLabel)
        contentView.addSubview(playSymbol)
        constraintViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with presentation: SearchPresentation) {
        mediaImageView.sd_setImage(with: URL(string: APIConstants.baseImageURL + presentation.image))
        titleLabel.text = presentation.title
        var type = presentation.type
        if type == "movie" {
            type = "Movie 🎬"
        } else {
            type = "TV Show 📺"
        }
        mediaTypeLabel.text = "\(type)"
    }
    
    func constraintViews() {
        let offset = 5
        mediaImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(offset)
            make.bottom.equalToSuperview().offset(-offset)
            make.leading.equalToSuperview().offset(offset)
            make.width.equalTo(120)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(offset)
            make.leading.equalTo(mediaImageView.snp.trailing).offset(offset)
            make.trailing.equalToSuperview().offset(-offset)
        }
        mediaTypeLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(offset)
            make.leading.equalTo(mediaImageView.snp.trailing).offset(offset)
            make.trailing.equalToSuperview().offset(-offset)
        }
        playSymbol.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
            
        }
        
    }
    
}
