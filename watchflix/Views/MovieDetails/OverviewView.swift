//
//  OverviewView.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 29.09.2022.
//
import SnapKit
import UIKit

class OverviewView: UIView {
    
    private let overviewTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines  = 1
        label.text = "Overview"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
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
        addSubview(overviewTitle)
        addSubview(overviewLabel)
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutViews() {
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
        overviewLabel.text = model.overview
    }
    

    

}
