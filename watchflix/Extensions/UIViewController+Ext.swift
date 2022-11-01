//
//  UIViewController+Ext.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 31.10.2022.
//

import UIKit
import SnapKit

fileprivate var containerView: UIView!


extension UIViewController {
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .secondarySystemBackground
        containerView.alpha           = 0
        
        UIView.animate(withDuration: 0.25, delay: 0) { containerView.alpha = 0.8 }
        
        let activityIndicator   = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .systemYellow
        containerView.addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    func alert(title: String, message: String, actionMessage: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionButton    = UIAlertAction(title: actionMessage, style: .default)
        alertController.addAction(actionButton)
        DispatchQueue.main.async { self.present(alertController, animated: true) }
    }
}


