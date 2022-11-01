//
//  ListCell.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 1.11.2022.
//

import UIKit
import SnapKit
import SDWebImage
class ListCell: UITableViewCell {
        
    static let identifier  = "ListCell"
    
    private let mediaImageView  = WFImageView(cornerRadius: 8, border: true, contentMode: .scaleToFill)
    private let titleLabel      = WFTitleLabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        layoutUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupCell() {
        addSubview(mediaImageView)
        addSubview(titleLabel)
        self.accessoryType = .disclosureIndicator
        self.backgroundColor = .secondarySystemBackground
    }
    
    private func layoutUI() {
        mediaImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.leading.equalToSuperview().offset(5)
            make.width.equalTo(120)
            make.height.equalTo(150)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalTo(mediaImageView.snp.trailing).offset(5)
            make.trailing.equalToSuperview().offset(-5)
        }
    }
    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        mediaImageView.sd_setImage(with: URL(string: APIConstants.baseImageURL + (movie.poster_path ?? "-")))
    }
}
