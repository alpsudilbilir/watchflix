//
//  OverviewView.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 29.09.2022.
//
import SnapKit
import UIKit

class OverviewView: UIView {
    
    private let overviewTitle = WFTitleLabel()
    private let overviewLabel = WFLabel(fontSize: 16, weight: .light, textAlignment: .natural)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(overviewTitle)
        addSubview(overviewLabel)
    }
    
    private func layoutUI() {
        overviewTitle.snp.makeConstraints { make in
            make.left.equalTo(snp.left).offset(5)
            make.right.equalTo(snp.right)
            make.height.greaterThanOrEqualTo(40)
        }
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(overviewTitle.snp.bottom)
            make.left.equalTo(snp.left).offset(5)
            make.right.equalTo(snp.right)
        }
    }
    
    func configure(with model: MovieDetailsResponse) {
        overviewTitle.text = "Overview"
        overviewLabel.text = model.overview
    }
    

    

}
