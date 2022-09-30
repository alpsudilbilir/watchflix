//
//  MovieTitleView.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 28.09.2022.
//

import UIKit
import SDWebImage

class MovieTitleView: UIView {
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "app-logo")
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.yellow.cgColor
        imageView.contentMode = .scaleToFill
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 70
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

    private let userScoreCirle: UIView = {
        
        let roundView = UIView(frame: CGRectMake(20, 20, 40, 40))
        roundView.backgroundColor = UIColor.secondarySystemBackground
        roundView.layer.cornerRadius = roundView.width / 2
        
        
        
        return roundView
    }()
    
    
    private let userScoreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
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

    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        
        movieImageView.frame = CGRect(
            x: 5,
            y: 5,
            width: 140,
            height: 140)
        titleLabel.frame = CGRect(
            x: movieImageView.rigth + 5,
            y: 5,
            width: width - movieImageView.width - 15,
            height: titleLabel.heigth)
        yearLabel.frame = CGRect(
            x: movieImageView.rigth + 5,
            y: titleLabel.bottom + 2,
            width: width - movieImageView.width - 10,
            height: yearLabel.heigth)
        infoLabel.frame = CGRect(
            x: movieImageView.rigth + 6,
            y: yearLabel.bottom + 3 ,
            width: width - movieImageView.width,
            height: infoLabel.heigth)
        userScoreCirle.frame = CGRect(
            x: movieImageView.rigth + 5,
            y: infoLabel.bottom + 10,
            width: userScoreCirle.width, height: userScoreCirle.heigth)
        
        userScoreLabel.frame = userScoreCirle.bounds
    }
    
    
    
    func configure(with model: MovieDetailsResponse) {
        //SCORE
        let score = Int(model.vote_average * 10.0) //6.7 -> 67
        let percentageScore = model.vote_average / 10 // 6.7 -> 0.67
        userScoreLabel.text = "\(score)﹪"
        configureCircleStroke(with: percentageScore)
        
        //IMAGE
        movieImageView.sd_setImage(with: URL(string: APIConstants.BASE_IMAGE_URL + model.poster_path))
        
        //TITLE
        
        titleLabel.text = model.title
        titleLabel.sizeToFit()
        
        //YEAR
        let releaseYear = model.release_date.components(separatedBy: "-").first ?? "-"
        yearLabel.text = "Year: \(releaseYear)"
        yearLabel.sizeToFit()
        
        
        
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
        infoLabel.sizeToFit()
        
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
        circleShape.fillColor = UIColor.secondarySystemBackground.cgColor
        circleShape.lineWidth = 5
        circleShape.strokeStart = 0.0
        circleShape.strokeEnd = score
        userScoreCirle.layer.addSublayer(circleShape)
        userScoreCirle.addSubview(userScoreLabel)
        userScoreCirle.sizeToFit()
        
    }
    
    
    
}
