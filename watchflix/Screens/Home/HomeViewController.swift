//
//  ViewController.swift
//  netflix-clone
//
//  Created by Alpsu Dilbilir on 6.09.2022.
//

import SnapKit
import UIKit

enum BrowseSectionType {
    case popularMovies (presentations  : [MoviePresentation])
    case trendingMovies(presentations  : [MoviePresentation])
    case topRatedMovies(presentations  : [MoviePresentation])
    case popularShows  (presentations  : [MoviePresentation])
    case topRatedShows (presentations  : [MoviePresentation])
    case nowPlayings   (presentations  : [MoviePresentation])
}

class HomeViewController: UIViewController {
    
    var sections         = [BrowseSectionType]()
    
    var popularMovies    = [Movie]()
    var trendingMovies   = [Movie]()
    var topRatedMovies   = [Movie]()
    var nowPlayingMovies = [Movie]()
    var popularShows     = [TV]()
    var topRatedShows    = [TV]()
    
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, _ -> NSCollectionLayoutSection? in
            return createLayout(sectionIndex: sectionIndex)
        }))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        setupCollectionView()
        fetchMovies()
    }

    private func configureViewController() {
        title = "Home"
        view.backgroundColor = .secondarySystemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: UIImageView(image: Images.barLogo))
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.frame                  = view.bounds
        collectionView.backgroundColor        = .secondarySystemBackground
        collectionView.delegate               = self
        collectionView.dataSource             = self
        
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.identifier)
    }
    
    private func fetchMovies() {
        showLoadingView()
        
        let group = DispatchGroup()
        group.enter()
        group.enter()
        group.enter()
        group.enter()
        group.enter()
        group.enter()
        
        MovieService.shared.request(for: .popular, type: MovieResponse.self) { [weak self] result in
            group.leave()
            guard let self = self else { return }
            switch result {
            case .success(let response):
                let movies          = response.results
                self.popularMovies += movies
            case .failure:
                self.alert(title: "Network Error", message: "Unable to get movies", actionMessage: "Try again")
            }
        }
        MovieService.shared.request(for: .trending, type: MovieResponse.self) { [weak self] result in
            group.leave()
            guard let self = self else { return }
            switch result {
            case .success(let response):
                let movies           = response.results
                self.trendingMovies += movies
            case .failure:
                self.alert(title: "Network Error", message: "Unable to get movies", actionMessage: "Try again")
            }
        }
        MovieService.shared.request(for: .topRated, type: MovieResponse.self) { [weak self] result in
            group.leave()
            guard let self = self else { return }
            switch result {
            case .success(let response):
                let movies           = response.results
                self.topRatedMovies += movies
            case .failure:
                self.alert(title: "Network Error", message: "Unable to get movies", actionMessage: "Try again")
            }
        }
        MovieService.shared.request(for: .popularTV, type: TVResponse.self) { [weak self] result in
            group.leave()
            guard let self = self else { return }
            switch result {
            case .success(let response):
                let series         = response.results
                self.popularShows += series
            case .failure:
                self.alert(title: "Network Error", message: "Unable to get movies", actionMessage: "Try again")
            }
        }
        MovieService.shared.request(for: .topRatedTV, type: TVResponse.self) { [weak self] result in
            group.leave()
            guard let self = self else { return }
            switch result {
            case .success(let response):
                let series          = response.results
                self.topRatedShows += series
            case .failure:
                self.alert(title: "Network Error", message: "Unable to get movies", actionMessage: "Try again")
            }
        }
        MovieService.shared.request(for: .nowPlaying, type: MovieResponse.self) { [weak self] result in
            group.leave()
            guard let self = self else { return }
            switch result {
            case .success(let response):
                let movies             = response.results
                self.nowPlayingMovies += movies
            case .failure:
                self.alert(title: "Network Error", message: "Unable to get movies", actionMessage: "Try again")

            }
        }
        group.notify(queue: .main) {
            self.configureSections()
            self.collectionView.reloadData()
            self.dismissLoadingView()
        }
    }
    
    private func configureSections() {
        self.sections.append(.popularMovies(presentations: self.popularMovies.map({
            return MoviePresentation(
                id        : $0.id,
                title     : $0.title,
                movieImage: $0.poster_path ?? "-")
        })))
        self.sections.append(.trendingMovies(presentations: self.trendingMovies.map({
            return MoviePresentation(
                id        : $0.id,
                title     : $0.title,
                movieImage: $0.poster_path ?? "-")
        })))
        self.sections.append(.topRatedMovies(presentations: self.topRatedMovies.map({
            return MoviePresentation(
                id        : $0.id,
                title     : $0.title,
                movieImage: $0.poster_path ?? "-")
        })))
        self.sections.append(.popularShows(presentations: self.popularShows.map({
            return MoviePresentation(
                id        : $0.id,
                title     : $0.name,
                movieImage: $0.poster_path ?? "-")
        })))
        
        self.sections.append(.topRatedShows(presentations: self.topRatedShows.map({
            return MoviePresentation(
                id        : $0.id,
                title     : $0.name,
                movieImage: $0.poster_path ?? "-")
        })))
        self.sections.append(.nowPlayings(presentations: self.nowPlayingMovies.map({
            return MoviePresentation(
                id        : $0.id,
                title     : $0.title,
                movieImage: $0.poster_path ?? "-")
        })))
    }
}

