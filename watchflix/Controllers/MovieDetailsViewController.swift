//
//  DetailsViewController.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 26.09.2022.
//
import SnapKit
import UIKit
import WebKit

enum Section {
    case cast(model: [Cast])
}

class MovieDetailsViewController: UIViewController, UIScrollViewDelegate, WKNavigationDelegate {
    
    var sections = [Section]()
    
    //MARK: - Subviews
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .secondarySystemBackground
        return scrollView
    }()
    private let webView: WKWebView = WKWebView()
    
    private let movieTitleView = MovieTitleView()
    private let overviewView = OverviewView()
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, _ in
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
    }))
    
    //MARK: - Initializing
    private var cast = [Cast]()
    private var similarMovies = [Movie]()
    let movie: Movie
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(movie.title)"
        view.backgroundColor = .secondarySystemBackground
        navigationController?.navigationBar.prefersLargeTitles = false
        
     
        setupViews()
        configureWebView()
        configureCollectionView()
        //        fetchTrailer()
        fetchMovie(by: movie.id)
        fetchCast()
        
    }
    private func configureCollectionView() {
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: CastCollectionViewCell.identifier)
        collectionView.register(SectionHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderCollectionReusableView.identifier)
    }
    private func configureWebView() {
        webView.layer.masksToBounds = true
        webView.layer.cornerRadius = 8
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
    }
    
    private func fetchCast() {
        MovieService.shared.getCast(with: movie.id) { [weak self] result in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let cast):
                    self?.cast = cast
                    strongSelf.sections.append(.cast(model: strongSelf.cast.map({
                        return Cast(
                            character: $0.character,
                            name: $0.name,
                            order: $0.order,
                            profile_path: $0.profile_path)
                        
                    })))
                case .failure(let error):
                    print(error.localizedDescription)
                }
                strongSelf.collectionView.reloadData()
            }
        }
    }
    
    private func fetchMovie(by id: Int) {
        MovieService.shared.getById(with: id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movieDetails):
                    self?.movieTitleView.configure(with: movieDetails)
                    self?.overviewView.configure(with: movieDetails)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        }
    }
    private func fetchTrailer() {
        YoutubeService.shared.getTrailer(with: movie.title + " trailer") { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let video):
                    let videoId = video.videoId
                    guard let url = URL(string: "https://www.youtube.com/embed/\(videoId)") else { return }
                    let request = URLRequest(url: url)
                    self?.webView.load(request)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    //MARK: - Constraint
    func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(webView)
        scrollView.addSubview(movieTitleView)
        scrollView.addSubview(overviewView)
        scrollView.addSubview(collectionView)
        scrollView.alwaysBounceVertical = true
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        }
        scrollView.contentSize = CGSize(width: self.view.width, height: self.view.heigth * 2)

        webView.snp.makeConstraints { make in
            make.top.equalTo(scrollView)
            make.width.equalToSuperview()
            make.height.equalTo(250)

        }
        movieTitleView.snp.makeConstraints { make in
            make.top.equalTo(webView.snp.bottom).offset(10)
            make.width.equalToSuperview()
            make.height.greaterThanOrEqualTo(180)
        }
        overviewView.snp.makeConstraints { make in
            make.top.equalTo(movieTitleView.snp.bottom).offset(10)
            make.width.equalToSuperview()
            make.height.greaterThanOrEqualTo(200)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(overviewView.snp.bottom)
            make.width.equalToSuperview()
            make.height.equalTo(500)
        }
        
    }
    
}

//MARK: - Collection View

extension MovieDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = sections[section]
        switch sectionType {
        case .cast(let cast):
            return cast.count
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let sectionType = sections[indexPath.section]
        switch sectionType {
        case .cast(let cast):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.identifier, for: indexPath) as? CastCollectionViewCell else {
                return UICollectionViewCell()
            }
            let person = cast[indexPath.row]
            cell.configure(with: person)
            cell.backgroundColor = .secondarySystemBackground
            cell.layer.cornerRadius = 18
            return cell
        }
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
        case .cast:
            header.configure(with: "Cast")
        }
        return header
    }
}
