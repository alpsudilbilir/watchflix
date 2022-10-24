//
//  Extensions.swift
//  watchflix
//
//  Created by Alpsu Dilbilir on 14.10.2022.
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
        UIView.animate(withDuration: 0.25, delay: 0) {
            containerView.alpha = 0.8
        }
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        activityIndicator.color = .systemYellow
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
}
extension UIView {
    var width: CGFloat {
        return frame.size.width
    }
    var heigth: CGFloat {
        return frame.size.height
    }
    var left: CGFloat {
        return frame.origin.x
    }
    var rigth: CGFloat {
        return left + width
    }
    var top: CGFloat {
        return frame.origin.y
    }
    var bottom: CGFloat {
        return top + heigth
    }
}
