//
//  OverviewView.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 29.09.2022.
//

import UIKit

class OverviewView: UIView {
    
    private let movieQuote: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    private let overviewTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines  = 1
        label.text = "Overview"
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    private let overviewLabel: UILabel =  {
        let label = UILabel()
        label.text = "Test"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .thin)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(movieQuote)
        addSubview(overviewTitle)
        addSubview(overviewLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        movieQuote.frame = CGRect(
            x: 5,
            y: 5,
            width: width - 10,
            height: movieQuote.heigth)
        overviewTitle.frame = CGRect(
            x: 5,
            y: movieQuote.bottom + 5,
            width: width,
            height: overviewTitle.heigth)
        
        overviewLabel.frame = CGRect(
            x: 5,
            y: overviewTitle.bottom + 5 ,
            width: width - 10,
            height: overviewLabel.heigth
        )
    }
    
    
    func configure(with model: MovieDetailsResponse) {
        movieQuote.text = model.tagline
        overviewLabel.text = model.overview
        movieQuote.sizeToFit()
        overviewTitle.sizeToFit()
        overviewLabel.sizeToFit()

    }
    

    

}
