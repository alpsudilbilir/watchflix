//
//  HomeHeaderCollectionReusableView.swift
//  netflix-clone
//
//  Created by Alpsu Dilbilir on 6.09.2022.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    static let identifier = "SectionHeaderCollectionReusableView"
    private let sectionTitleLabel = WFTitleLabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(sectionTitleLabel)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        sectionTitleLabel.frame = CGRect(
            x: 5,
            y: 0,
            width: frame.size.width,
            height: 40)
    }
    func configure(with title: String) {
        sectionTitleLabel.text = title
    }
}
