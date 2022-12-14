//
//  ResultsTableViewCell.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 12.10.2022.
//

import UIKit
import SnapKit
import SDWebImage
class SearchResultsCell: UITableViewCell {
    static let identifier = "ResultsTableViewCell"
    
    private let mediaImageView  = WFImageView(cornerRadius: 10, border: false, contentMode: .scaleToFill)
    private let titleLabel      = WFTitleLabel()
    private let mediaTypeLabel  = WFLabel(fontSize: 15, weight: .regular, textAlignment: .natural)
    private let playSymbol      = {
        let imageView       = UIImageView()
        imageView.image     = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 20)))
        imageView.tintColor = .label
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(mediaImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(mediaTypeLabel)
        contentView.addSubview(playSymbol)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with presentation: SearchPresentation) {
        var type = presentation.type
        if type == "movie" {
            type = "Movie 🎬"
        } else { type = "TV Show 📺" }
        
        titleLabel.text     = presentation.title
        mediaTypeLabel.text = "\(type)"
        mediaImageView.sd_setImage(with: URL(string: APIConstants.baseImageURL + presentation.image))

    }
    func layoutUI() {
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
