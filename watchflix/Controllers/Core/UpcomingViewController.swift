//
//  ComingSoonViewController.swift
//  netflix-clone
//
//  Created by Alpsu Dilbilir on 6.09.2022.
//

import UIKit

class UpcomingViewController: UIViewController {
    
    private var upcomingMovies = [Movie]()
    private var viewModels = [UpcomingsPresentation]()
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UpcomingTableViewCell.self, forCellReuseIdentifier: UpcomingTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Upcoming"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        fetchUpcomings()
    }
    func fetchUpcomings() {
        MovieService.shared.getUpcomings { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let upcomings):
                DispatchQueue.main.async {
                    strongSelf.upcomingMovies = upcomings.reversed()
                    strongSelf.viewModels.append(contentsOf: strongSelf.upcomingMovies.compactMap({
                        return UpcomingsPresentation(
                            title: $0.title,
                            movieImage: $0.poster_path ?? "-",
                            overview: $0.overview)
                    }))
                    strongSelf.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
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
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingTableViewCell.identifier, for: indexPath) as? UpcomingTableViewCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .secondarySystemBackground
        let viewModel = viewModels[indexPath.row]
        cell.configure(with: viewModel)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    
}
