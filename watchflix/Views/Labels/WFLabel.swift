//
//  WFLabel.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 31.10.2022.
//


import UIKit

class WFLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(fontSize: CGFloat, weight: UIFont.Weight, textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        font               = .systemFont(ofSize: fontSize, weight: weight)
        self.textAlignment = textAlignment
        configure()
    }
    
    private func configure() {
        textColor                  = .label
        lineBreakMode              = .byTruncatingTail
        numberOfLines              = 0
    }
}
