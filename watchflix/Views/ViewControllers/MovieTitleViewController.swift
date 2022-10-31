//
//  MovieTitleViewController.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 28.09.2022.
//

import UIKit
import SDWebImage
import SnapKit

protocol MovieTitleViewControllerDelegate: AnyObject {
    func addToFavorites(_ button: WFSymbolButton)
    func addToWatchlist(_ button: WFSymbolButton)
}

class MovieTitleViewController: UIViewController {
    
    private let movieImageView  = WFImageView(cornerRadius: 25, border: true, contentMode: .scaleToFill)
    private let titleLabel      = WFTitleLabel()
    private let yearLabel       = WFLabel(fontSize: 14, weight: .regular, textAlignment: .natural)
    private let infoLabel       = WFLabel(fontSize: 14, weight: .regular, textAlignment: .natural)
    private let movieQuote      = WFLabel(fontSize: 14, weight: .regular, textAlignment: .natural)
    private let userScoreLabel  = WFLabel(fontSize: 14, weight: .bold, textAlignment: .center)
    private let favoriteButton  = WFSymbolButton(symbol: SFSymbols.heart)
    private let watchlistButton = WFSymbolButton(symbol: SFSymbols.bookmark)
    private let userScoreCirle  = {
        let roundView = UIView(frame: CGRectMake(20, 20, 50, 50))
        roundView.backgroundColor    = UIColor.secondarySystemBackground
        roundView.layer.cornerRadius = roundView.width / 2
        return roundView
    }()

    
    weak var delegate: MovieTitleViewControllerDelegate?
    var movieDetail: MovieDetailsResponse
    
    init(movieDetail: MovieDetailsResponse) {
        self.movieDetail = movieDetail
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        setupViews()
        configureButtons()
        layoutUI()
        configure(with: movieDetail)
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        let views = [movieImageView, titleLabel, yearLabel, infoLabel, movieQuote, userScoreCirle, favoriteButton, watchlistButton]
        views.forEach { view.addSubview($0) }
        userScoreCirle.addSubview(userScoreLabel)
        
    }
    private func configureButtons() {
        favoriteButton.addTarget(self, action: #selector(didTapFavorite), for: .touchUpInside)
        watchlistButton.addTarget(self, action: #selector(didTapWatchlist), for: .touchUpInside)
    }
    @objc private func didTapFavorite() {
        delegate?.addToFavorites(favoriteButton)
        
    }
    @objc private func didTapWatchlist() {
        delegate?.addToWatchlist(watchlistButton)
    }
    
    private func layoutUI() {
        movieImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(5)
            make.width.equalTo(150)
            make.height.equalTo(190)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(movieImageView.snp.trailing).offset(5)
            make.trailing.equalTo(view.snp.trailing).offset(-5)
            make.height.equalTo(24)
        }
        yearLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(movieImageView.snp.trailing).offset(5)
            make.trailing.equalTo(view.snp.trailing).offset(-5)
            make.width.lessThanOrEqualTo(view.width - movieImageView
                .width)
        }
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(yearLabel.snp.bottom).offset(5)
            make.leading.equalTo(movieImageView.snp.trailing).offset(5)
            make.trailing.equalTo(view.snp.trailing).offset(-5)
            make.height.greaterThanOrEqualTo(20)
        }
        movieQuote.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(5)
            make.leading.equalTo(movieImageView.snp.trailing).offset(5)
            make.trailing.equalTo(view.snp.trailing).offset(-5)
            make.height.greaterThanOrEqualTo(20)
        }
        watchlistButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.leading.equalTo(movieImageView.snp.trailing).offset(10)
            make.width.height.equalTo(25)
        }
        favoriteButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.leading.equalTo(watchlistButton.snp.trailing).offset(35)
            make.width.height.equalTo(25)
        }
        
        userScoreCirle.snp.makeConstraints { make in
            make.bottom.equalTo(movieImageView.snp.bottom)
            make.trailing.equalToSuperview().offset(-20)
            make.width.height.equalTo(50)
        }
        userScoreLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
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
