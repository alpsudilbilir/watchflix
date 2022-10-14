//
//  CastCollectionViewCell.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 30.09.2022.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {
    static let identifier = "CastCollectionViewCell"
    private let personImageView : UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "app-logo")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        return imageView
    }()
    
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(personImageView)
        contentView.addSubview(nameLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        personImageView.frame = CGRect(
            x: 0,
            y: 0,
            width: contentView.width,
            height: contentView.heigth - 40)
        nameLabel.frame = CGRect(
            x: 0,
            y: personImageView.bottom,
            width: contentView.width,
            height: 50)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: Cast) {
     
        personImageView.sd_setImage(with: URL(string: APIConstants.baseImageURL + (model.profile_path ?? "-") ))
        nameLabel.text = "\(model.name)\n\(model.character)"
        nameLabel.textAlignment = .center
        nameLabel.sizeToFit()
                                    
    }
    
    
}
