//
//  SearchViewController.swift
//  netflix-clone
//
//  Created by Alpsu Dilbilir on 6.09.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    private let searchController = UISearchController(searchResultsController: SearchResultsViewController())
    private let collectionView   = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private var popularMovies    = [Movie]()
    private var presentations    = [MoviePresentation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        fetchPopularMovies()
    }
    
    private func configureViewController() {
        title = "Search"
        view.backgroundColor = .secondarySystemBackground
    }
    
    @objc private func didTapSearch() {
        collectionView.scrollsToTop = true
    }
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.frame           = view.bounds
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.delegate        = self
        collectionView.dataSource      = self
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
    }
    
    private func configureSearchController() {
        navigationItem.searchController             = searchController
        navigationItem.hidesSearchBarWhenScrolling  = false
        searchController.searchBar.placeholder      = "Movies and TV Shows"
        searchController.searchBar.searchBarStyle   = .prominent
        searchController.definesPresentationContext = true
        searchController.searchBar.delegate         = self
        searchController.searchResultsUpdater       = self
    }
    
    private func fetchPopularMovies() {
        showLoadingView()
        MovieService.shared.request(for: .popular, type: MovieResponse.self) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                let movies          = response.results
                self.popularMovies += movies
                self.configurePresentations(with: movies)
                self.dismissLoadingView()
            case .failure(let error): print(error)
            }
            DispatchQueue.main.async { self.collectionView.reloadData() }
        }
    }
    
    private func configurePresentations(with movies: [Movie]) {
        self.presentations.append(contentsOf: movies.compactMap({
            return MoviePresentation(
                id        : $0.id,
                title     : $0.title,
                movieImage: $0.poster_path ?? "-")}))
    }
}

//MARK: - Collection View

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        popularMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        let movie = presentations[indexPath.row]
        cell.configure(with: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let movie = popularMovies[indexPath.row]
        let vc    = MovieDetailsViewController(movie: movie)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY       = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height        = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            APIConstants.page += 1
            fetchPopularMovies()
        }
    }
}

//MARK: - Search Controller

extension SearchViewController: UISearchBarDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {}
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let resultsController = searchController.searchResultsController as? SearchResultsViewController,
              var query             = searchController.searchBar.text  else { return }
        query                       = query.replacingOccurrences(of: " ", with: "%20")
        resultsController.delegate  = self
        
        MovieService.shared.search(with: query) { result in
            switch result {
            case .success(let response):
                resultsController.update(with: response)
            case .failure(let error): print(error)
            }
        }
    }
}

//MARK: - Search Results Controller

extension SearchViewController: SearchResultsViewControllerDelegate {
    
    func didTapResult(_ result: Media) {
        let movie = Movie(id: result.id, title: (result.title ?? result.name) ?? "-", overview: nil, poster_path: result.poster_path, release_date: nil)
        let vc    = MovieDetailsViewController(movie: movie)
        navigationController?.pushViewController(vc, animated: true)
    }
}
