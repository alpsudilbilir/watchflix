//
//  DetailsViewController.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 26.09.2022.
//

import UIKit
import WebKit

class MovieDetailsViewController: UIViewController, UIScrollViewDelegate, WKNavigationDelegate {
    
    private let webView: WKWebView = WKWebView()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .secondarySystemBackground
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    

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
        title = "\(movie.title)"
        view.backgroundColor = .secondarySystemBackground
        navigationController?.navigationBar.prefersLargeTitles = false
        view.addSubview(scrollView)
        scrollView.addSubview(webView)
        scrollView.contentSize = CGSize(width: self.view.width, height: self.view.heigth * 2 )

        configureWebView()
        
        fetchTrailer()
    }
    
    private func configureWebView() {
        webView.backgroundColor = .systemBackground
        
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        scrollView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: view.heigth - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
        webView.frame = CGRect(x: 5, y: 0, width: scrollView.width - 10, height: 250)
        webView.layer.masksToBounds = true
        webView.layer.cornerRadius = 8
        
    }
 

}
