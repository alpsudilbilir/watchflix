//
//  ViewController.swift
//  netflix-clone
//
//  Created by Alpsu Dilbilir on 6.09.2022.
//

import UIKit

enum BrowseSectionType {
    case popularMovies(viewModel: [MovieViewModel])
    case trendingMovies(viewModel: [MovieViewModel])
    case topRatedMovies(viewModel: [MovieViewModel])
    case popularShows(viewModel: [MovieViewModel])
    case topRatedShows(viewModel: [MovieViewModel])
    case nowPlayings(viewModel: [MovieViewModel])
    
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
            return HomeViewController.createLayout(sectionIndex: sectionIndex)
        }))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = .systemBackground
        setupCollectionView()
        setupNavigationBar()
        fetchMovies()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
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
        
        navigationItem.rightBarButtonItems = [logo, person]
    }
    @objc func didTapMenuButton() { }
    @objc func didTapProfileButton() { }
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        collectionView.register(SectionHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderCollectionReusableView.identifier)
    }
    private func fetchMovies() {
        let group = DispatchGroup()
        group.enter()
        group.enter()
        group.enter()
        group.enter()
        group.enter()
        group.enter()
        while APIConstants.PAGE < 4 {
            MovieService.shared.getPopularMovies{ [weak self] result in
                
                guard let strongSelf = self else { return }
                switch result {
                case .success(let popularMovies):
                    strongSelf.popularMovies += popularMovies
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
            
            MovieService.shared.getTrendingMovies { [weak self] result in
                guard let strongSelf = self else { return }
                switch result {
                case .success(let trendingMovies):
                    strongSelf.trendingMovies += trendingMovies
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            MovieService.shared.getTopRatedMovies { [weak self] result in
                guard let strongSelf = self else { return }
                switch result {
                case .success(let topMovies):
                    strongSelf.topRatedMovies += topMovies
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            MovieService.shared.getPopularSeries { [weak self] result in
                guard let strongSelf = self else { return }
                switch result {
                case .success(let popularSeries):
                    strongSelf.popularShows += popularSeries
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }

            MovieService.shared.getTopRatedSeries { [weak self] result in
                guard let strongSelf = self else { return }
                switch result {
                case .success(let topRatedSeries):
                    strongSelf.topRatedShows += topRatedSeries
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            MovieService.shared.getNowPlayings { [weak self] result in
                guard let strongSelf = self else { return }
                switch result {
                case .success(let nowPlayings):
                    strongSelf.nowPlayingMovies += nowPlayings
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            APIConstants.PAGE += 1
        }
        group.leave()
        group.leave()
        group.leave()
        group.leave()
        group.leave()
        group.leave()
        
        group.notify(queue: .main) {
            
            self.configureSections()
            self.collectionView.reloadData()
            APIConstants.PAGE = 1
            
        }
    }
    private func configureSections() {
        self.sections.append(.popularMovies(viewModel: self.popularMovies.map({
            return MovieViewModel(
                title: $0.title,
                movieImage: $0.poster_path ?? "-")
        })))
        self.sections.append(.trendingMovies(viewModel: self.trendingMovies.map({
            return MovieViewModel(
                title: $0.title,
                movieImage: $0.poster_path ?? "-")
        })))
        self.sections.append(.topRatedMovies(viewModel: self.topRatedMovies.map({
            return MovieViewModel(
                title: $0.title,
                movieImage: $0.poster_path ?? "-")
        })))
        self.sections.append(.popularShows(viewModel: self.popularShows.map({
            return MovieViewModel(
                title: $0.name,
                movieImage: $0.poster_path ?? "-")
        })))

        self.sections.append(.topRatedShows(viewModel: self.topRatedShows.map({
            return MovieViewModel(
                title: $0.name,
                movieImage: $0.poster_path ?? "-")
        })))
        self.sections.append(.nowPlayings(viewModel: self.nowPlayingMovies.map({
            return MovieViewModel(
                title: $0.title,
                movieImage: $0.poster_path ?? "-")
        })))
    }
}

