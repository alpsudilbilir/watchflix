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
        case .topList(let items):
            return items.count
        case .trendingMovies(let items):
            return items.count
        case .newReleases(let items):
            return  items.count
        case .recommendedMovies(let items):
            return items.count
        case .headerMovies(let items):
            return items.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        let sectionType = sections[indexPath.section]
        switch sectionType {
        case .recommendedMovies:
            cell.backgroundColor = .yellow
            return cell
        case .newReleases:
            cell.backgroundColor = .red
            return cell
        case .trendingMovies:
            cell.backgroundColor = .blue
            return cell
        case .topList:
            cell.backgroundColor = .purple
            return cell
        case .headerMovies:
            cell.backgroundColor = .brown
            return cell
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
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
        case .newReleases :
            header.configure(with: "New Releases")
        case .topList :
            header.configure(with: "Top List")
        case .recommendedMovies:
            header.configure(with: "Recommended")
        case .trendingMovies :
            header.configure(with: "Editor Selected")
        default:
            header.configure(with: "")
        }
        return header
    }
    
    static func createLayout(sectionIndex: Int) -> NSCollectionLayoutSection  {
        switch sectionIndex {
        case 0: //Header Movies
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)))
            item.contentInsets = NSDirectionalEdgeInsets(
                top: 5, leading: 5, bottom: 5, trailing: 5)
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalWidth(1)),
                subitem: item,
                count: 1)
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPaging
            
            return section
        default: //Other Movies
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
                top: 5, leading: 5, bottom: 5, trailing: 5)
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.8),
                    heightDimension: .absolute(200)),
                subitem: item,
                count: 2)
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.boundarySupplementaryItems = sectionBoundaryItem
            return section
        }
    }
}
