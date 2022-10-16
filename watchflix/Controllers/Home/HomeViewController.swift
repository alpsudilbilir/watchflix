//
//  ViewController.swift
//  netflix-clone
//
//  Created by Alpsu Dilbilir on 6.09.2022.
//

import SnapKit
import UIKit

enum BrowseSectionType {
    case popularMovies(viewModel: [MoviePresentation])
    case trendingMovies(viewModel: [MoviePresentation])
    case topRatedMovies(viewModel: [MoviePresentation])
    case popularShows(viewModel: [MoviePresentation])
    case topRatedShows(viewModel: [MoviePresentation])
    case nowPlayings(viewModel: [MoviePresentation])
    
}
class HomeViewController: UIViewController {
    var sections = [BrowseSectionType]()
    
    var popularMovies = [Movie]()
    var trendingMovies = [Movie]()
    var topRatedMovies = [Movie]()
    var nowPlayingMovies = [Movie]()
    
    var popularShows = [TV]()
    var topRatedShows = [TV]()
    
    private var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, _ -> NSCollectionLayoutSection? in
            return createLayout(sectionIndex: sectionIndex)
        }))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = .secondarySystemBackground
        setupCollectionView()
        setupNavigationBar()
        fetchMovies()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.alwaysBounceVertical = true
        collectionView.alwaysBounceHorizontal = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.identifier)
    }
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "list.dash"),
            style: .done,
            target: self,
            action: #selector(didTapMenuButton))
        
        let person = UIBarButtonItem(
            image: UIImage(systemName: "person"),
            style: .done,
            target: self,
            action: #selector(didTapProfileButton))
        let logo = UIBarButtonItem(customView: UIImageView(image: UIImage(named: "bar_logo")))
        
        navigationItem.rightBarButtonItems = [logo, person]
    }
    @objc func didTapMenuButton() { }
    @objc func didTapProfileButton() { }
    private func alert() {
        let alert = UIAlertController(title: "Network Error", message: "Check your internet connection and try again.", preferredStyle: .alert)
        let tryAgain = UIAlertAction(title: "Try again", style: .default) { _ in
            self.fetchMovies()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(tryAgain)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    private func fetchMovies() {
        MovieService.shared.request(for: .popular, type: MovieResponse.self) { [weak self] result in
            switch result {
            case .success(let response):
                let movies = response.results
                self?.popularMovies += movies
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                    self?.alert()
                }
            }
        }
        MovieService.shared.request(for: .trending, type: MovieResponse.self) { [weak self] result in
            switch result {
            case .success(let response):
                let movies = response.results
                self?.trendingMovies += movies
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                    self?.alert()
                }
            }
        }
        MovieService.shared.request(for: .topRated, type: MovieResponse.self) { [weak self] result in
            switch result {
            case .success(let response):
                let movies = response.results
                self?.topRatedMovies += movies
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                    self?.alert()
                }
            }
        }
        MovieService.shared.request(for: .popularTV, type: TVResponse.self) { [weak self] result in
            switch result {
            case .success(let response):
                let series = response.results
                self?.popularShows += series
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                    
                }
            }
        }
        
        MovieService.shared.request(for: .topRatedTV, type: TVResponse.self) { [weak self] result in
            switch result {
            case .success(let response):
                let series = response.results
                self?.topRatedShows += series
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                    self?.alert()
                }
            }
        }
        MovieService.shared.request(for: .nowPlaying, type: MovieResponse.self) { [weak self] result in
            switch result {
            case .success(let response):
                let movies = response.results
                self?.nowPlayingMovies += movies
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                    self?.alert()
                }
            }
        }
        DispatchQueue.main.async {
            self.configureSections()
            self.collectionView.reloadData()
        }
    }
    private func configureSections() {
        self.sections.append(.popularMovies(viewModel: self.popularMovies.map({
            return MoviePresentation(
                id: $0.id,
                title: $0.title,
                movieImage: $0.poster_path ?? "-")
        })))
        self.sections.append(.trendingMovies(viewModel: self.trendingMovies.map({
            return MoviePresentation(
                id: $0.id,
                title: $0.title,
                movieImage: $0.poster_path ?? "-")
        })))
        self.sections.append(.topRatedMovies(viewModel: self.topRatedMovies.map({
            return MoviePresentation(
                id: $0.id,
                title: $0.title,
                movieImage: $0.poster_path ?? "-")
        })))
        self.sections.append(.popularShows(viewModel: self.popularShows.map({
            return MoviePresentation(
                id: $0.id,
                title: $0.name,
                movieImage: $0.poster_path ?? "-")
        })))
        
        self.sections.append(.topRatedShows(viewModel: self.topRatedShows.map({
            return MoviePresentation(
                id: $0.id,
                title: $0.name,
                movieImage: $0.poster_path ?? "-")
        })))
        self.sections.append(.nowPlayings(viewModel: self.nowPlayingMovies.map({
            return MoviePresentation(
                id: $0.id,
                title: $0.title,
                movieImage: $0.poster_path ?? "-")
        })))
    }
}

