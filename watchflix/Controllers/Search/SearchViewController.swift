//
//  SearchViewController.swift
//  netflix-clone
//
//  Created by Alpsu Dilbilir on 6.09.2022.
//

import UIKit

class SearchViewController: UIViewController {
    private var popularMovies = [Movie]()
    private var presentations = [MoviePresentation]()

    private let searchController: UISearchController = {
        let vc = UISearchController(searchResultsController: SearchResultsViewController())
        vc.searchBar.placeholder = "Movies and TV Shows"
        vc.searchBar.searchBarStyle = .prominent
        vc.definesPresentationContext = true
        return vc
    }()
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        view.backgroundColor = .secondarySystemBackground
        configureSearchController()
        configureCollectionView()
        fetchPopularMovies()
    }
    @objc private func didTapSearch() {
        collectionView.scrollsToTop = true
    }
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
    }
    private func configureSearchController() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
    }
    private func fetchPopularMovies() {
        
        MovieService.shared.request(for: .popular, type: MovieResponse.self) {[weak self] result in
            switch result {
            case .success(let response):
                let movies = response.results
                self?.popularMovies = movies
                self?.presentations = movies.map({
                    return MoviePresentation(id: $0.id, title: $0.title, movieImage: $0.poster_path ?? "-")
                })
            case .failure(let error):
                print(error)
             }
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
}
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        popularMovies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else {
            return UICollectionViewCell()
        }
        let movie = presentations[indexPath.row]
        cell.configure(with: movie)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let movie = popularMovies[indexPath.row]
        let vc = MovieDetailsViewController(movie: movie)
        navigationController?.pushViewController(vc, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5)
    }
}
//MARK: - Search Controller Delegate
extension SearchViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) { }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let resultsController = searchController.searchResultsController as? SearchResultsViewController,
              var query = searchController.searchBar.text  else { return }
        query = query.replacingOccurrences(of: " ", with: "%20")
        resultsController.delegate = self
        MovieService.shared.search(with: query) {[weak self] result in
            switch result {
            case .success(let response):
                resultsController.update(with: response)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}
//MARK: - Search Results Controller Delegate
extension SearchViewController: SearchResultsViewControllerDelegate {
    func didTapResult(_ result: Media) {
        let movie = Movie(id: result.id, title: (result.title ?? result.name) ?? "-", overview: nil, poster_path: result.poster_path, release_date: nil)
        let vc = MovieDetailsViewController(movie: movie)
        navigationController?.pushViewController(vc, animated: true)
    }
}
