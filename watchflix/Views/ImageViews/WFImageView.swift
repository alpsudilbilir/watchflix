//
//  WFImageView.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 15.10.2022.
//

import UIKit

class WFImageView: UIImageView {
    
    init(cornerRadius: CGFloat, border: Bool, contentMode: ContentMode) {
        super.init(frame: .zero)
        self.layer.cornerRadius = cornerRadius
        self.contentMode        = contentMode
        if border {
            layer.borderColor  = UIColor.yellow.cgColor
            layer.borderWidth  = 1
        }
        configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        image              = UIImage(named: "app-logo")
        clipsToBounds      = true
    }
}
