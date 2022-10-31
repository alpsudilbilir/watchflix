//
//  WFButton.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 31.10.2022.
//

import UIKit

class WFSymbolButton: UIButton {
    
    init(symbol: String) {
        super.init(frame: .zero)
        configure(with: symbol)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with symbol: String) {
        var config         = UIButton.Configuration.plain()
        config.image       = UIImage(systemName: symbol, withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))
        tintColor          = .label
        configuration      = config
    }
}
