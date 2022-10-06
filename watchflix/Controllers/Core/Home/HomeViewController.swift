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
            return HomeViewController.createLayout(sectionIndex: sectionIndex)
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
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        collectionView.register(SectionHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderCollectionReusableView.identifier)
    }
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
                    self?.alert()
                }
            }
            
            
            MovieService.shared.getTrendingMovies { [weak self] result in
                guard let strongSelf = self else { return }
                switch result {
                case .success(let trendingMovies):
                    strongSelf.trendingMovies += trendingMovies
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.alert()
                }
            }
            MovieService.shared.getTopRatedMovies { [weak self] result in
                guard let strongSelf = self else { return }
                switch result {
                case .success(let topMovies):
                    strongSelf.topRatedMovies += topMovies
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.alert()
                }
            }
            MovieService.shared.getPopularSeries { [weak self] result in
                guard let strongSelf = self else { return }
                switch result {
                case .success(let popularSeries):
                    strongSelf.popularShows += popularSeries
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.alert()
                }
            }

            MovieService.shared.getTopRatedSeries { [weak self] result in
                guard let strongSelf = self else { return }
                switch result {
                case .success(let topRatedSeries):
                    strongSelf.topRatedShows += topRatedSeries
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.alert()
                }
            }
            MovieService.shared.getNowPlayings { [weak self] result in
                guard let strongSelf = self else { return }
                switch result {
                case .success(let nowPlayings):
                    strongSelf.nowPlayingMovies += nowPlayings
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.alert()
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

