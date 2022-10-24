//
//  CastCollectionViewCell.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 30.09.2022.
//

import UIKit

class CastCell: UICollectionViewCell {
    static let identifier = "CastCollectionViewCell"
    private let personImageView = WFImageView(cornerRadius: 16, border: false, contentMode: .scaleAspectFill)
    private let nameLabel       = WFLabel(fontSize: 13, weight: .medium, textAlignment: .left)
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(personImageView)
        contentView.addSubview(nameLabel)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        personImageView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().offset(-40)
        }
        nameLabel.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(personImageView.snp.bottom)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(with model: Cast) {
        if let photo = model.profile_path {
            personImageView.sd_setImage(with: URL(string: APIConstants.baseImageURL + photo ))
        }
        
        nameLabel.text = "\(model.name)\n\(model.character)"
        nameLabel.textAlignment = .center
        nameLabel.sizeToFit()
    }
}
