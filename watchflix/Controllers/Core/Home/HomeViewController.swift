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
    
}

class HomeViewController: UIViewController {
    var sections = [BrowseSectionType]()
    
    private var popularMovies = [Movie]()
    private var trendingMovies = [Movie]()
    private var topRatedMovies = [Movie]()
    
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
        fetchMovies()
    }
    private func fetchMovies() {
        let group = DispatchGroup()
        group.enter()
        group.enter()
        group.enter()
        
        
        MovieService.shared.getPopularMovies{ [weak self] result in
            group.leave()
            guard let strongSelf = self else { return }
            switch result {
            case .success(let popularMovies):
                strongSelf.popularMovies = popularMovies
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        MovieService.shared.getTrendingMovies { [weak self] result in
            group.leave()
            guard let strongSelf = self else { return }
            switch result {
            case .success(let trendingMovies):
                strongSelf.trendingMovies = trendingMovies
            case .failure(let error):
                print("Error when fetching movies.")
            }
        }
        MovieService.shared.getTopRatedMovies { [weak self] result in
            group.leave()
            guard let strongSelf = self else { return }
            switch result {
            case .success(let topMovies):
                strongSelf.topRatedMovies = topMovies
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        group.notify(queue: .main) {
            self.sections.append(.popularMovies(viewModel: self.popularMovies.compactMap({
                return MovieViewModel(
                    title: $0.title,
                    movieImage: $0.poster_path ?? "-")
            })))
            self.sections.append(.trendingMovies(viewModel: self.trendingMovies.compactMap({
                return MovieViewModel(
                    title: $0.title,
                    movieImage: $0.poster_path ?? "-")
            })))
            self.sections.append(.topRatedMovies(viewModel: self.topRatedMovies.compactMap({
                return MovieViewModel(
                    title: $0.title,
                    movieImage: $0.poster_path ?? "-")
            })))
            self.collectionView.reloadData()
        }
        
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        collectionView.register(SectionHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderCollectionReusableView.identifier)
    }
    
}

