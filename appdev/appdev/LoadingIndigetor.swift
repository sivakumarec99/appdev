//
//  LoadingIndigetor.swift
//  appdev
//
//  Created by JIDTP1408 on 23/01/25.
//

import Foundation
import UIKit

class LoadingIndicator {
    
    // Singleton instance
    static let shared = LoadingIndicator()
    
    // The loading view and its subviews
    private var loadingView: UIView!
    private var activityIndicator: UIActivityIndicatorView!
    private var loadingImageView: UIImageView!
    private var loadingLabel: UILabel!
    
    private init() { }
    
    // Function to show the loading indicator
    func show(on view: UIView, message: String = "Loading...") {
        // Check if loading view already exists, if not, create it
        if loadingView == nil {
            setupLoadingView(on: view)
        }
        
        // Update label message
        loadingLabel.text = message
        
        // Show the loading view
        loadingView.isHidden = false
        activityIndicator.startAnimating()
    }
    
    // Function to hide the loading indicator
    func hide() {
        activityIndicator.stopAnimating()
        loadingView.isHidden = true
    }
    
    // Function to set up the loading view
    private func setupLoadingView(on parentView: UIView) {
        // Create and configure the loading view
        loadingView = UIView()
        loadingView.backgroundColor = UIColor(white: 0, alpha: 0.7)
        loadingView.layer.cornerRadius = 10
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(loadingView)
        
        // Add constraints to position it at the top of the screen
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.topAnchor, constant: 20),
            loadingView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 20),
            loadingView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -20),
            loadingView.heightAnchor.constraint(equalToConstant: 80) // Height of the loading view
        ])
        
        // Add the activity indicator (spinner)
        activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingView.addSubview(activityIndicator)
        
        // Add constraints to center the activity indicator within the loading view
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor),
            activityIndicator.leadingAnchor.constraint(equalTo: loadingView.leadingAnchor, constant: 20)
        ])
        
        // Add an image (for example, a loading icon)
        loadingImageView = UIImageView(image: UIImage(named: "loading_icon"))
        loadingImageView.contentMode = .scaleAspectFit
        loadingImageView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.addSubview(loadingImageView)
        
        // Add constraints for the image
        NSLayoutConstraint.activate([
            loadingImageView.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor),
            loadingImageView.leadingAnchor.constraint(equalTo: activityIndicator.trailingAnchor, constant: 20),
            loadingImageView.widthAnchor.constraint(equalToConstant: 40),
            loadingImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Add a label (for the loading text)
        loadingLabel = UILabel()
        loadingLabel.text = "Loading..."
        loadingLabel.textColor = .white
        loadingLabel.font = UIFont.systemFont(ofSize: 16)
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        loadingView.addSubview(loadingLabel)
        
        // Add constraints for the label
        NSLayoutConstraint.activate([
            loadingLabel.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor),
            loadingLabel.leadingAnchor.constraint(equalTo: loadingImageView.trailingAnchor, constant: 10),
            loadingLabel.trailingAnchor.constraint(equalTo: loadingView.trailingAnchor, constant: -20)
        ])
    }
}
