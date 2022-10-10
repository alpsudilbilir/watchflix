//
//  WatchListButton.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 10.10.2022.
//

import UIKit

class WatchListButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        let image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 20)))
        self.setImage(image, for: .normal)
        tintColor = .label
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
