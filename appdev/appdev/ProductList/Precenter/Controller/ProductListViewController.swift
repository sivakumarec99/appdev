//
//  ProductListViewController.swift
//  appdev
//
//  Created by JIDTP1408 on 04/02/25.
//

import UIKit

class ProductListViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var isGridView = true
    let products = HouseholdProducts.products
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupToggleButton()
        self.view.setScreenCaptureProtection()
    }
    
  
    
    
    func setupCollectionView() {
        let layout = createGridLayout()
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")
        view.addSubview(collectionView)
    }
    
    func createGridLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width / 2 - 10, height: 150)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        return layout
    }
    
    func createListLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width - 20, height: 100)
        layout.minimumLineSpacing = 10
        return layout
    }
    
    func setupToggleButton() {
        let toggleButton = UIBarButtonItem(title: "Toggle", style: .plain, target: self, action: #selector(toggleLayout))
        navigationItem.rightBarButtonItem = toggleButton
    }
    
    @objc func toggleLayout() {
        isGridView.toggle()
        self.performSelector(onMainThread: #selector(reloadCollectionView), with: nil, waitUntilDone: true)

    }
    @objc func reloadCollectionView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.collectionView.collectionViewLayout.invalidateLayout()
        }) { _ in
            self.collectionView.reloadData()
        }
    }
    
}

extension ProductListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        let product = products[indexPath.item]
        DispatchQueue.main.async {
            cell.configure(with: product)
        }
        return cell
    }
}
extension ProductListViewController: UICollectionViewDelegateFlowLayout {
    
    // Set Dynamic Item Size Based on Layout Mode
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isGridView {
            let width = (collectionView.frame.width / 2) - 10 // Two columns
            return CGSize(width: width, height: width + 40) // Square shape
        } else {
            return CGSize(width: collectionView.frame.width - 20, height: 80) // List rectangle
        }

    }

    // Set Dynamic Spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return isGridView ? 10 : 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return isGridView ? 10 : 0
    }
}
