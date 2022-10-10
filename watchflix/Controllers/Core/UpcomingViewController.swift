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
        tableView.register(UpcomingTableViewCell.self, forCellReuseIdentifier: UpcomingTableViewCell.identifier)
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
        MovieService.shared.getUpcomings { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let upcomings):
                strongSelf.upcomingMovies = upcomings.reversed()
                self?.configurePresentations()
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
    private func configurePresentations() {
        DispatchQueue.main.async {
            self.presentations.append(contentsOf: self.upcomingMovies.compactMap({
                return UpcomingsPresentation(
                    title: $0.title,
                    movieImage: $0.poster_path ?? "-",
                    overview: $0.overview,
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingTableViewCell.identifier, for: indexPath) as? UpcomingTableViewCell else {
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
}
