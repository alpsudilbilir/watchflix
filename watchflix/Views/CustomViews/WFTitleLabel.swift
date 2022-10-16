//
//  WFTitleLabel.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 15.10.2022.
//

import UIKit

class WFTitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init() {
        super.init(frame: .zero)
        configure()
    }
    private func configure() {
        textColor                  = .label
        adjustsFontSizeToFitWidth  = true
        minimumScaleFactor         = 0.9
        lineBreakMode              = .byTruncatingTail
        font                       = .systemFont(ofSize: 20, weight: .semibold)
        numberOfLines              = 2
    }
    
}
