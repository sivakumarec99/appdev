//
//  ProductCell.swift
//  appdev
//
//  Created by JIDTP1408 on 04/02/25.
//

import UIKit
import MapKit

class ProductCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    let nameLabel = UILabel()
    let priceLabel = UILabel()
    let locationButton = UIButton()
    
    let shimmerLayer = CAGradientLayer()
    var isLoading = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientBackground()
        setupShimmerEffect()
        setupBorderAndShadow()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        // Configure Image View
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure Labels
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        priceLabel.font = UIFont.systemFont(ofSize: 14)
        nameLabel.text = "Loading..."
        priceLabel.text = "Loading..."
        nameLabel.textColor = .clear
        priceLabel.textColor = .clear
        
        // Configure Location Button
        locationButton.setImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        locationButton.tintColor = .blue
        locationButton.addTarget(self, action: #selector(openLocation), for: .touchUpInside)
        
        // StackView for Labels & Button
        let textStack = UIStackView(arrangedSubviews: [nameLabel, priceLabel, locationButton])
        textStack.axis = .vertical
        textStack.spacing = 5
        
        // Main StackView
        let mainStack = UIStackView(arrangedSubviews: [imageView, textStack])
        mainStack.axis = .horizontal
        mainStack.spacing = 10
        mainStack.alignment = .center
        addSubview(mainStack)
        
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 60),
            imageView.heightAnchor.constraint(equalToConstant: 60),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            mainStack.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    // MARK: - Gradient Background
    func setupGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.white.cgColor,
            UIColor.systemGray6.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = 12
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // MARK: - Border & Shadow
    func setupBorderAndShadow() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray4.cgColor
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 6
        layer.masksToBounds = false
    }
    
    override var isSelected: Bool {
        didSet {
            animateBorder(isSelected: isSelected)
        }
    }
    
    func animateBorder(isSelected: Bool) {
        let color: CGColor = isSelected ? UIColor.blue.cgColor : UIColor.systemGray4.cgColor
        let animation = CABasicAnimation(keyPath: "borderColor")
        animation.fromValue = layer.borderColor
        animation.toValue = color
        animation.duration = 0.3
        layer.borderColor = color
        layer.add(animation, forKey: "borderColorAnimation")
    }
    
    // MARK: - Shimmer Effect
    func setupShimmerEffect() {
        
        shimmerLayer.colors = [
            UIColor(white: 0.85, alpha: 1).cgColor,
            UIColor(white: 0.95, alpha: 1).cgColor,
            UIColor(white: 0.85, alpha: 1).cgColor
        ]
        shimmerLayer.startPoint = CGPoint(x: 0, y: 0.5)
        shimmerLayer.endPoint = CGPoint(x: 1, y: 0.5)
        shimmerLayer.frame = bounds
        shimmerLayer.locations = [0.0, 0.5, 1.0]
        layer.addSublayer(shimmerLayer)
        
        let shimmerAnimation = CABasicAnimation(keyPath: "locations")
        shimmerAnimation.fromValue = [-1.0, -0.5, 0.0]
        shimmerAnimation.toValue = [1.0, 1.5, 2.0]
        shimmerAnimation.duration = 1.2
        shimmerAnimation.repeatCount = .infinity
        shimmerLayer.add(shimmerAnimation, forKey: "shimmerEffect")
    }
    
    func stopShimmerEffect() {
        shimmerLayer.removeFromSuperlayer()
    }
    
    // MARK: - Configure Cell Data
    func configure(with product: Product) {
        nameLabel.text = product.name
        priceLabel.text = "$\(product.price)"
        imageView.image = UIImage(named: product.imageUrl)
        locationButton.tag = tag
        
        isLoading = false
        stopShimmerEffect()
        
        // Fade-in Animation
        UIView.animate(withDuration: 0.3) {
            self.nameLabel.textColor = .black
            self.priceLabel.textColor = .darkGray
        }
    }
    
    // MARK: - Open Location in Maps
    @objc func openLocation() {
        let locationName = nameLabel.text ?? ""
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = locationName
        
        let search = MKLocalSearch(request: searchRequest)
        search.start { response, error in
            if let coordinate = response?.mapItems.first?.placemark.coordinate {
                let url = URL(string: "maps://?q=\(coordinate.latitude),\(coordinate.longitude)")!
                UIApplication.shared.open(url)
            }
        }
    }
}
