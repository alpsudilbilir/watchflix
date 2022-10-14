//
//  MovieTitleView.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 28.09.2022.
//

import UIKit
import SDWebImage
import SnapKit

class MovieTitleView: UIView {
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.yellow.cgColor
        imageView.contentMode = .scaleToFill
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let movieQuote: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.italicSystemFont(ofSize: 14)
        return label
    }()

    private let userScoreCirle: UIView = {
        
        let roundView = UIView(frame: CGRectMake(20, 20, 40, 40))
        roundView.backgroundColor = UIColor.secondarySystemBackground
        roundView.layer.cornerRadius = roundView.width / 2
        return roundView
    }()
    
    
    
    private let userScoreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .label
        label.font = .systemFont(ofSize: 13, weight: .bold)
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(movieImageView)
        addSubview(yearLabel)
        addSubview(infoLabel)
        addSubview(userScoreCirle)
        addSubview(movieQuote)
        userScoreCirle.addSubview(userScoreLabel)
        layoutViews()

    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func layoutViews() {
        movieImageView.snp.makeConstraints { make in
            make.left.equalTo(5)
            make.width.equalTo(150)
            make.height.equalTo(189)
        }
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(movieImageView.snp.right).offset(5)
            make.right.equalTo(snp.right).offset(5)
            make.height.greaterThanOrEqualTo(20)
        }
        yearLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.equalTo(movieImageView.snp.right).offset(5)
            make.right.equalTo(snp.right).offset(5)
            make.width.lessThanOrEqualTo(width - movieImageView
                .width)
        }
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(yearLabel.snp.bottom).offset(5)
            make.left.equalTo(movieImageView.snp.right).offset(5)
            make.right.equalTo(snp.right).offset(5)
            make.width.lessThanOrEqualTo(width - movieImageView
                .width).offset(-10)
            make.height.greaterThanOrEqualTo(20)
        }
        movieQuote.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(5)
            make.left.equalTo(movieImageView.snp.right).offset(5)
            make.right.equalTo(snp.right).offset(-5)
            make.height.greaterThanOrEqualTo(20)
        }
        userScoreCirle.snp.makeConstraints { make in
            make.bottom.equalTo(movieImageView.snp.bottom).offset(-5)
            make.right.equalTo(snp.right).offset(-20)
            make.width.height.equalTo(50)
        }
        userScoreLabel.snp.makeConstraints { make in
            make.center.equalTo(userScoreCirle.snp.center)
            make.width.height.equalTo(40)
        }
    }
    
    
    
    func configure(with model: MovieDetailsResponse) {
        //SCORE
        let score = Int(model.vote_average * 10.0) //6.7 -> 67
        let percentageScore = model.vote_average / 10 // 6.7 -> 0.67
        userScoreLabel.text = "\(score)﹪"
        configureCircleStroke(with: percentageScore)
        //IMAGE
        movieImageView.sd_setImage(with: URL(string: APIConstants.baseImageURL + model.poster_path))
        //TITLE
        titleLabel.text = model.title
        //YEAR
        let releaseYear = model.release_date.components(separatedBy: "-").first ?? "-"
        yearLabel.text = "Year: \(releaseYear)"
        //GENRE & TIME
        var genreString = ""
        model.genres.forEach { genre in
            if genre.name != model.genres.last?.name {
                genreString += "\(genre.name), "
            } else {
                genreString += genre.name
            }
        }
        let movieTime = model.runtime ?? 0 // 119 Int
        let hour = movieTime / 60
        let minute = movieTime % 60
        let durationString = "\(hour)h \(minute)m"
        infoLabel.text = genreString + " ・ " + durationString
        movieQuote.text = model.tagline
    }
    func configureCircleStroke(with score: Double) {
        let circlePath = UIBezierPath(arcCenter: CGPoint (x: userScoreCirle.width / 2, y: userScoreCirle.width / 2),
                                      radius: userScoreCirle.width / 2,
                                      startAngle: CGFloat(-0.5 * Double.pi),
                                      endAngle: CGFloat(1.5 * Double.pi),
                                      clockwise: true)
        let circleShape = CAShapeLayer()
        circleShape.path = circlePath.cgPath
        circleShape.strokeColor = UIColor.yellow.cgColor
        circleShape.fillColor = UIColor.white.withAlphaComponent(0.00001).cgColor
        circleShape.lineWidth = 5
        circleShape.strokeStart = 0.0
        circleShape.strokeEnd = score
        userScoreCirle.layer.addSublayer(circleShape)
    }
}
