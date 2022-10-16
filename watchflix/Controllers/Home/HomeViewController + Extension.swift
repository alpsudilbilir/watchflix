//
//  HomeViewController + Extension.swift
//  netflix-clone
//
//  Created by Alpsu Dilbilir on 6.09.2022.
//

import Foundation
import UIKit

//MARK: - Collection View

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = sections[section]
        switch sectionType {
        case .popularMovies(let popularMovies):
            return popularMovies.count
        case .trendingMovies(let trendingMovies):
            return trendingMovies.count
        case .topRatedMovies(let topRatedMovies):
            return topRatedMovies.count
        case .popularShows(let popularShows):
            return popularShows.count
        case .topRatedShows(let topRatedShows):
            return topRatedShows.count
        case .nowPlayings(let nowplayings):
            return nowplayings.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else {
            return UICollectionViewCell()
        }
        let sectionType = sections[indexPath.section]
        
        switch sectionType {
        case .popularMovies(let viewModels):
            let viewModel = viewModels[indexPath.row]
            cell.configure(with: viewModel)
            cell.backgroundColor = .secondarySystemBackground
            return cell
        case .trendingMovies(let viewModels):
            let viewModel = viewModels[indexPath.row]
            cell.configure(with: viewModel)
            cell.backgroundColor = .secondarySystemBackground
            return cell
        case .topRatedMovies(let viewModels):
            let viewModel = viewModels[indexPath.row]
            cell.configure(with: viewModel)
            cell.backgroundColor = .secondarySystemBackground
            return cell
        case .popularShows(let viewModels):
            let viewModel = viewModels[indexPath.row]
            cell.configure(with: viewModel)
            cell.backgroundColor = .secondarySystemBackground
            return cell
        case .topRatedShows(let viewModels):
            let viewModel = viewModels[indexPath.row]
            cell.configure(with: viewModel)
            cell.backgroundColor = .secondarySystemBackground
            return cell
        case .nowPlayings(let viewModels):
            let viewModel = viewModels[indexPath.row]
            cell.configure(with: viewModel)
            cell.backgroundColor = .secondarySystemBackground
            return cell   
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let section = sections[indexPath.section]
        
        var show: TV
        switch section {
        case .popularMovies:
             let movie = popularMovies[indexPath.row]
            let vc = MovieDetailsViewController(movie: movie)
            navigationController?.pushViewController(vc, animated: true)

        case .trendingMovies:
             let movie = trendingMovies[indexPath.row]
            let vc = MovieDetailsViewController(movie: movie)
            navigationController?.pushViewController(vc, animated: true)

        case .topRatedMovies:
             let movie = topRatedMovies[indexPath.row]
            let vc = MovieDetailsViewController(movie: movie)
            navigationController?.pushViewController(vc, animated: true)

        case .popularShows:
             show = popularShows[indexPath.row]
        case .topRatedShows:
             show = topRatedShows[indexPath.row]
        case .nowPlayings:
             let movie = nowPlayingMovies[indexPath.row]
            let vc = MovieDetailsViewController(movie: movie)

            navigationController?.pushViewController(vc, animated: true)

        }
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: SectionHeader.identifier,
            for: indexPath) as? SectionHeader else {
            return UICollectionReusableView()
        }
        let sectionType = sections[indexPath.section]
        switch sectionType {
        case .popularMovies:
            header.configure(with: "Popular")
        case .trendingMovies :
            header.configure(with: "Trending")
        case .topRatedMovies :
            header.configure(with: "Top Rated")
        case .popularShows :
            header.configure(with: "Popular TV Series")
        case .topRatedShows:
            header.configure(with: "Top 20 ")
        default:
            header.configure(with: "")
        }
        return header
    }
}
