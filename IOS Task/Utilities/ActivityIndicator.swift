//
//  ActivityIndicator.swift
//  Proball Sports
//
//  Created by Ahamad on 02/03/2023.
//


import UIKit

final class ActivityIndicator {
    
    private lazy var contentView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        view.backgroundColor = .init(white: 0.4, alpha: 0.8)
        view.layer.cornerRadius = 10
        
        let activityIndicator = UIActivityIndicatorView.setupImageLoadingAnimation(in: view)
        activityIndicator.color = .white
        
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .init(white: 0.25, alpha: 0.25)
        
        contentView.center = view.center
        view.addSubview(contentView)

        return view
    }()
}

extension ActivityIndicator {
    
    public func startAnimation() {
        UIApplication.shared.windows.first?.addSubview(self.containerView)
    }
    
    public func stopAnimation() {
        self.containerView.removeFromSuperview()
    }
}



extension UIActivityIndicatorView {
    
    public static func setupImageLoadingAnimation(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        view.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        let centerX = NSLayoutConstraint(item: view,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: activityIndicator,
                                         attribute: .centerX,
                                         multiplier: 1,
                                         constant: 0)
        let centerY = NSLayoutConstraint(item: view,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: activityIndicator,
                                         attribute: .centerY,
                                         multiplier: 1,
                                         constant: 0)
        
        view.addConstraints([centerX, centerY])
        
        return activityIndicator
    }
}


extension UISegmentedControl{
    func selectedSegmentTintColor(_ color: UIColor) {
        self.setTitleTextAttributes([.foregroundColor: color], for: .selected)
    }
    func unselectedSegmentTintColor(_ color: UIColor) {
        self.setTitleTextAttributes([.foregroundColor: color], for: .normal)
    }
}
