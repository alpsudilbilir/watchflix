//
//  SearchResultsViewController.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 12.10.2022.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    func didTapResult(_ result: Media)
}

class SearchResultsViewController: UIViewController {
    
    weak var delegate: SearchResultsViewControllerDelegate?
    
    var mediaItems         = [Media]()
    var mediaPresentations = [SearchPresentation]()
    
    private let tableView  = UITableView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    private func configureViewController() {
        view.backgroundColor = .clear
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame      = view.bounds
        tableView.isHidden   = true
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.register(SearchResultsCell.self, forCellReuseIdentifier: SearchResultsCell.identifier)
    }
    
    func update(with results: [Media]) {
        self.mediaItems    = results
        mediaPresentations = results.compactMap({
            return SearchPresentation(title: $0.title ?? $0.name ?? "-",
                                      image: $0.poster_path ?? "-",
                                      type : $0.media_type)
        })
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.isHidden = self.mediaPresentations.isEmpty
        }
    }
}

//MARK: - Search Results

extension SearchResultsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell         = tableView.dequeueReusableCell(withIdentifier: SearchResultsCell.identifier, for: indexPath) as! SearchResultsCell
        let presentation = mediaPresentations[indexPath.row]
        cell.configure(with: presentation)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 130 }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let result = mediaItems[indexPath.row]
        delegate?.didTapResult(result)
    }
}
