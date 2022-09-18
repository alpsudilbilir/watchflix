//
//  ViewController.swift
//  netflix-clone
//
//  Created by Alpsu Dilbilir on 6.09.2022.
//

import UIKit

enum BrowseSectionType {
    //TODO: Change items types
    case headerMovies(items: [Int])
    case newReleases(items: [Int])
    case recommendedMovies(items: [Int])
    case topList(items: [Int])
    case trendingMovies(items: [Int])
}

class HomeViewController: UIViewController {
    
    
    var sections = [BrowseSectionType]()
    
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
        setupNavBar()
        fetchMovies()
    }
    private func fetchMovies() {
        //TODO: - Fetch Data from real API.
        DispatchQueue.main.async {
            self.sections.append(.headerMovies(items: [1,2,3,4,5,6,1,1]))
            self.sections.append(.topList(items: [1,2,3,24,1,13,]))
            self.sections.append(.newReleases(items: [1,1,1,1,1,1,1]))
            self.sections.append(.recommendedMovies(items: [1,2,3,4,5,1,1,1]))
            self.sections.append(.trendingMovies(items: [1,2,3]))
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
    private func setupNavBar() {
        //TODO: Not working fix it 
        navigationController?.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "bar_logo"),
            style: .done,
            target: self,
            action: nil)
    }
}

