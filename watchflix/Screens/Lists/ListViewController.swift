//
//  DownloadsViewController.swift
//  netflix-clone
//
//  Created by Alpsu Dilbilir on 6.09.2022.
//

import UIKit
import SnapKit
class ListsViewController: UIViewController {
    
    private let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Favorites","Watchlist"])
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemYellow]
        sc.setTitleTextAttributes(titleTextAttributes, for: .selected)
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(didChanged), for: .valueChanged)
        return sc
    }()
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    private var watchlist = [Movie]()
    private var favorites = [Movie]()
    private var itemsToDisplay = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Lists"
        view.backgroundColor = .secondarySystemBackground
        addSubviews()
        configureTableView()
        layoutUI()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        getFavorites()
        getWatchlist()
    }
    @objc private func didChanged() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            itemsToDisplay = favorites
            DispatchQueue.main.async { self.tableView.reloadData() }
        case 1:
            itemsToDisplay = watchlist
            DispatchQueue.main.async { self.tableView.reloadData() }
        default: break
        }
    }

    
    private func getWatchlist() {
        PersistenceService.getMovies(type: .watchlist) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movies):
                self.watchlist = movies
                DispatchQueue.main.async { self.tableView.reloadData() }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getFavorites() {
        PersistenceService.getMovies(type: .favorite) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movies):
                self.favorites = movies
                self.itemsToDisplay = self.favorites
                DispatchQueue.main.async { self.tableView.reloadData() }
            case .failure(let error):
                print(error)
            }
        }
    }
    private func addSubviews() {
        view.addSubview(segmentedControl)
        view.addSubview(tableView)
    }
    private func configureTableView() {
        tableView.backgroundColor = .secondarySystemBackground
        tableView.register(ListCell.self, forCellReuseIdentifier: ListCell.identifier)
        tableView.dataSource = self
        tableView.delegate   = self
        
    }
    private func layoutUI() {
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.trailing.equalToSuperview().offset(-3)
            make.leading.equalToSuperview().offset(3)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom)
            make.trailing.leading.bottom.equalToSuperview()
        }
    }
}

extension ListsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemsToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier, for: indexPath) as! ListCell
        let movie = itemsToDisplay[indexPath.row]
        cell.configure(with: movie)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = self.itemsToDisplay[indexPath.row]
        let destVC = MovieDetailsViewController(movie: movie)
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    
}
