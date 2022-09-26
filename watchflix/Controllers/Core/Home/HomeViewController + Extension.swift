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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
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
        var movie: Movie? = nil
        var show: TV
        switch section {
        case .popularMovies:
             movie = popularMovies[indexPath.row]
        case .trendingMovies:
             movie = trendingMovies[indexPath.row]
        case .topRatedMovies:
             movie = topRatedMovies[indexPath.row]
        case .popularShows:
             show = popularShows[indexPath.row]
        case .topRatedShows:
             show = topRatedShows[indexPath.row]
        case .nowPlayings:
             movie = nowPlayingMovies[indexPath.row]
        }
        
        let vc = DetailsViewController(movie: movie)
        navigationController?.pushViewController(vc, animated: true)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: SectionHeaderCollectionReusableView.identifier,
            for: indexPath) as? SectionHeaderCollectionReusableView else {
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
    
    static func createLayout(sectionIndex: Int) -> NSCollectionLayoutSection  {
        switch sectionIndex {
        case 5:
            
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)))
            item.contentInsets = NSDirectionalEdgeInsets(
                top: 10, leading: 3, bottom: 3, trailing: 3)
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(400),
                    heightDimension: .absolute(250)),
                subitem: item,
                count: 2)
            let section = NSCollectionLayoutSection(group: group)
            return section
        default:
            let sectionBoundaryItem = [
                NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(40)),
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top),
            ]
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)))
            item.contentInsets = NSDirectionalEdgeInsets(
                top: 3, leading: 3, bottom: 3, trailing: 3)
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.8),
                    heightDimension: .absolute(250)),
                subitem: item,
                count: 2)
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.boundarySupplementaryItems = sectionBoundaryItem
            return section
        }
    }
}
