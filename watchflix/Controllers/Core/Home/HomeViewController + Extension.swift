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
        case .popularMovies(let movies):
            return movies.count
        case .trendingMovies(let movies):
            return movies.count
        case .topRatedMovies(let movies):
            return movies.count
            
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
            
        }
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
        case .trendingMovies :
            header.configure(with: "Trending Movies")
        case .topRatedMovies :
            header.configure(with: "Top Rated")
        default:
            header.configure(with: "")
        }
        return header
    }
    
    static func createLayout(sectionIndex: Int) -> NSCollectionLayoutSection  {
        switch sectionIndex {
        case 0: //Popular
            
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3 , bottom: 3, trailing: 3)
            
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(300)),
                subitem: item,
                count: 1)
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPaging
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
                    widthDimension: .fractionalWidth(0.9),
                    heightDimension: .absolute(300)),
                subitem: item,
                count: 2)

            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.boundarySupplementaryItems = sectionBoundaryItem
            return section
        }
    }
}
