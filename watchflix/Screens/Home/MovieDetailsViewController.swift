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
    case similarMovies(model: [Movie])
}

class MovieDetailsViewController: UIViewController, UIScrollViewDelegate, WKNavigationDelegate {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .secondarySystemBackground
        return scrollView
    }()
    private let container               = UIView()
    private let webView                 = WKWebView()
    private let movieTitleView          = UIView()
    private let overviewView            = OverviewView()
    private let collectionView          = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, _ in
        layoutMovieDetailsCollectionView(sectionIndex: sectionIndex)
    }))
    
    var sections              = [Section]()
    private var cast          = [Cast]()
    private var similarMovies = [Movie]()
    
    let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        setupViews()
        configureWebView()
        configureCollectionView()
        fetchTrailer()
        fetchMovie(by: movie.id)
        fetchCollectionViewData()
        layoutUI()
    }
    
    private func configureViewController() {
        title                                                  = "\(movie.title)"
        view.backgroundColor                                   = .secondarySystemBackground
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(container)
        container.addSubview(webView)
        container.addSubview(movieTitleView)
        container.addSubview(overviewView)
        container.addSubview(collectionView)
    }
    
    private func configureWebView() {
        webView.layer.masksToBounds                 = true
        webView.layer.cornerRadius                  = 8
        webView.navigationDelegate                  = self
        webView.allowsBackForwardNavigationGestures = true
    }

    private func configureCollectionView() {
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.isScrollEnabled = false
        collectionView.delegate        = self
        collectionView.dataSource      = self
        
        collectionView.register(CastCell.self, forCellWithReuseIdentifier: CastCell.identifier)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.identifier)
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
    }
    
    private func fetchMovie(by id: Int) {
        MovieService.shared.request(with: id, for: nil, type: MovieDetailsResponse.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movieDetails):
                self.configureUIElements(with: movieDetails)
            case .failure:
                self.alert(title: "Network Error", message: "Unable to get movies right now. Please check your internet connection", actionMessage: "Ok")
            }
        }
    }
    
    private func fetchTrailer() {
        YoutubeService.shared.getTrailer(with: movie.title + " trailer") { [weak self] result in
                switch result {
                case .success(let video):
                    let videoId   = video.videoId
                    guard let url = URL(string: "https://www.youtube.com/embed/\(videoId)") else { return }
                    let request   = URLRequest(url: url)
                    DispatchQueue.main.async { self?.webView.load(request) }
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }

    private func fetchCollectionViewData() {
        let group = DispatchGroup()
        group.enter()
        group.enter()
        
        MovieService.shared.request(with: movie.id, for: .cast, type: CastResponse.self) { [weak self] result in
            group.leave()
            switch result {
            case .success(let response):
                let cast   = response.cast
                self?.cast = cast
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        MovieService.shared.request(with: movie.id, for: .similarMovies, type: MovieResponse.self) { [weak self] result in
            group.leave()
            switch result {
            case .success(let response):
                let movies          = response.results
                self?.similarMovies = movies
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        group.notify(queue: .main) {
            self.configureSections()
            self.collectionView.reloadData()
        }
    }
    
    private func configureSections() {
        self.sections.append(.cast(model: self.cast.map({
            return Cast(
                character   : $0.character,
                name        : $0.name,
                order       : $0.order,
                profile_path: $0.profile_path,
                id          : $0.id)
        })))
        self.sections.append(.similarMovies(model: self.similarMovies.map({
            return Movie(
                id          : $0.id,
                title       : $0.title,
                overview    : $0.overview,
                poster_path : $0.poster_path ?? "-",
                release_date: nil)
        })))
    }


    private func configureUIElements(with movieDetail: MovieDetailsResponse) {
        DispatchQueue.main.async {
            let vc      = MovieTitleViewController(movieDetail: movieDetail)
            vc.delegate = self
            self.add(childVC: vc, to: self.movieTitleView)
            self.overviewView.configure(with: movieDetail)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = CGSize(width: container.frame.width, height: container.frame.height)
    }
    
    private func layoutUI() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        }
        container.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(1400)
        }
        webView.snp.makeConstraints { make in
            make.top.equalTo(container)
            make.height.equalTo(250)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
        }
        movieTitleView.snp.makeConstraints { make in
            make.top.equalTo(webView.snp.bottom).offset(10)
            make.width.equalToSuperview()
            make.height.greaterThanOrEqualTo(200)
        }
        overviewView.snp.makeConstraints { make in
            make.top.equalTo(movieTitleView.snp.bottom).offset(10)
            make.width.equalToSuperview()
            make.height.greaterThanOrEqualTo(200)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(overviewView.snp.bottom)
            make.width.equalToSuperview()
            make.height.equalTo(750)
        }
    }
}

//MARK: - Collection View

extension MovieDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = sections[section]
        switch sectionType {
        case .cast(let cast)           : return cast.count
        case .similarMovies(let movies): return movies.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int { sections.count }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = sections[indexPath.section]
        switch sectionType {
        case .cast(let cast):
            let cell                = collectionView.dequeueReusableCell(withReuseIdentifier: CastCell.identifier, for: indexPath) as! CastCell
            let person              = cast[indexPath.row]
            cell.backgroundColor    = .secondarySystemBackground
            cell.layer.cornerRadius = 18
            cell.configure(with: person)
            return cell
        case .similarMovies:
            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
            let movie = similarMovies[indexPath.row]
            cell.configure(with: MoviePresentation(id: movie.id, title: movie.title, movieImage: movie.poster_path ?? "-"))
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        switch section {
        case .similarMovies:
            let movie = similarMovies[indexPath.row]
            let vc    = MovieDetailsViewController(movie: movie)
            navigationController?.pushViewController(vc, animated: true)
        case .cast:
            let personID = cast[indexPath.row].id
            let vc       = PersonViewController(personID: personID)
            navigationController?.modalPresentationStyle = .formSheet
            navigationController?.present(vc, animated: true)
        }
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
        case .cast         : header.configure(with: "Cast")
        case .similarMovies: header.configure(with: "Similar")
        }
        return header
    }
}

//MARK: - Movie Details Protocol

extension MovieDetailsViewController: MovieTitleViewControllerDelegate {
    
    func toggleFavorites(_ button: WFSymbolButton) {
        PersistenceService.updateWith(movie: self.movie, listType: .favorite, button: button) { error in
            if let error = error { print(error.rawValue) }
        }
    }
    
    func toggleWatchlist(_ button: WFSymbolButton) {
        PersistenceService.updateWith(movie: self.movie, listType: .watchlist, button: button) { error in
            if let error = error { print(error.rawValue) }
        }
    }
}
