//
//  CollectionViewHelper.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 15.10.2022.
//

import UIKit

//MARK: - Home Collection View Layout
func createLayout(sectionIndex: Int) -> NSCollectionLayoutSection  {
    let sectionBoundaryItem = [
        NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(40)),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top),
    ]
    switch sectionIndex {
    case 0, 1, 2, 3, 4:
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 3, leading: 3, bottom: 3, trailing: 3)
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
    default:
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 5, leading: 5, bottom: 5, trailing: 5)
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(250)),
            subitem: item,
            count: 2)
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = sectionBoundaryItem

        return section

    }
}
//MARK: - Movie Collection View Layout
func layoutMovieDetailsCollectionView(sectionIndex: Int) -> NSCollectionLayoutSection? {
    switch sectionIndex {
    case 0: //Cast Section
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
            top: 3, leading: 5, bottom: 3, trailing: 5)
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
    case 1: //Similar Movies Section
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
                widthDimension: .absolute(220),
                heightDimension: .absolute(180)))
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 5, leading: 5, bottom: 5, trailing: 5)
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)),
            subitem: item,
            count: 3)
        let verticalGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(380)),
            subitem: group,
            count: 2)
        let section = NSCollectionLayoutSection(group: verticalGroup)
        section.orthogonalScrollingBehavior = .groupPaging
        section.boundarySupplementaryItems = sectionBoundaryItem
        return section
    default:
        return nil
    }
}
