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
        
        MovieService.shared.getPopularMovies{ [weak self] result in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let popularMovies):
                    strongSelf.popularMovies = popularMovies
                    strongSelf.sections.append(.popularMovies(viewModel: popularMovies.compactMap({
                        return MovieViewModel(
                            title: $0.title,
                            movieImage: $0.poster_path ?? "-")
                    })))
                    strongSelf.collectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        MovieService.shared.getTrendingMovies { [weak self] result in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let trendingMovies):
                    strongSelf.trendingMovies = trendingMovies
                    strongSelf.sections.append(.trendingMovies(viewModel: strongSelf.trendingMovies.compactMap({
                        return MovieViewModel(
                            title: $0.title,
                            movieImage: $0.poster_path ?? "-")
                    })))
                    strongSelf.collectionView.reloadData()
                case .failure(let error):
                    print("Error when fetching movies.")
                }
            }
        }
        MovieService.shared.getTopRatedMovies { [weak self] result in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let topMovies):
                    strongSelf.topRatedMovies = topMovies
                    strongSelf.sections.append(.topRatedMovies(viewModel: strongSelf.topRatedMovies.compactMap({
                        return MovieViewModel(
                            title: $0.title,
                            movieImage: $0.poster_path ?? "-")
                    })))
                    self?.collectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
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

