//
//  DetailsViewController.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 26.09.2022.
//

import UIKit

class DetailsViewController: UIViewController, UIScrollViewDelegate {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.text = "asdsadawdasdsadawdasdsadawdasdsadawdasdsadawdasdsadawdasdsadawdasdsadawdasdsadawdasdsadawdasdsadawdasdsadawdasdsadawdasdsadawdasdsada"
        return label
    }()
    
    let movie: Movie?
    
    init(movie: Movie?) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(movie!.title) + \(movie!.id)"
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.addSubview(label)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        
        label.frame = CGRect(x: 0, y: 0, width: label.width, height: label.heigth)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.alwaysBounceVertical
    }

}
