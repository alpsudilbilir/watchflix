//
//  ComingSoonViewController.swift
//  netflix-clone
//
//  Created by Alpsu Dilbilir on 6.09.2022.
//

import UIKit

class UpcomingViewController: UIViewController {
    
    private var upcomingMovies = [Movie]()
    private var presentations = [UpcomingsPresentation]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UpcomingsCell.self, forCellReuseIdentifier: UpcomingsCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Upcoming"
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .secondarySystemBackground
        fetchUpcomings()
    }
    
    private func fetchUpcomings() {
        showLoadingView()
            MovieService.shared.request(for: .upcoming, type: MovieResponse.self) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    let upcomings = response.results
                    self.upcomingMovies += upcomings
                    self.configurePresentations(with: upcomings)
                    self.dismissLoadingView()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    
    private func formatDate(with date: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        let date = dateFormatterGet.date(from: date)
        let formattedDate = dateFormatterPrint.string(from: date!)
        return formattedDate
    }
    private func configurePresentations(with upcomings: [Movie]) {
        DispatchQueue.main.async {
            self.presentations.append(contentsOf: upcomings.compactMap({
                return UpcomingsPresentation(
                    title: $0.title,
                    movieImage: $0.poster_path ?? "-",
                    overview: $0.overview ?? "Not Found",
                    releaseDate: self.formatDate(with: $0.release_date ?? "-"))
            }))
            self.tableView.reloadData()
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
}
//MARK: - Table View
extension UpcomingViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presentations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingsCell.identifier, for: indexPath) as? UpcomingsCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .secondarySystemBackground
        let presentationModel = presentations[indexPath.row]
        cell.configure(with: presentationModel)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        250
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = upcomingMovies[indexPath.row]
        let vc = MovieDetailsViewController(movie: movie)
        navigationController?.pushViewController(vc, animated: true)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY       = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height        = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            APIConstants.page += 1
            fetchUpcomings()
        }
    }
}
