//
//  CollectionViewCell.swift
//  appdev
//
//  Created by JIDTP1408 on 28/01/25.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cameraImage: UIImageView!
    
    @IBOutlet weak var cameraName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        
              cameraImage.translatesAutoresizingMaskIntoConstraints = false
              cameraImage.contentMode = .scaleAspectFill
              cameraImage.layer.cornerRadius = 50 // Round the image
              cameraImage.layer.masksToBounds = true
              contentView.addSubview(cameraImage)
              
              cameraName.translatesAutoresizingMaskIntoConstraints = false
              cameraName.textAlignment = .center
              contentView.addSubview(cameraName)
              
              NSLayoutConstraint.activate([
                  cameraImage.topAnchor.constraint(equalTo: contentView.topAnchor),
                  cameraImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                  cameraImage.widthAnchor.constraint(equalToConstant: 100),
                  cameraImage.heightAnchor.constraint(equalToConstant: 100),
                  
                  cameraName.topAnchor.constraint(equalTo: cameraImage.bottomAnchor, constant: 8),
                  cameraName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                  cameraName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                  cameraName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
              ])

    }
          
    func configure(with media: Media) {
        cameraImage.image = media.image
        cameraName.text = media.name
    }
    
    func NibName()-> UINib{
        return UINib(nibName: "CollectionViewCell", bundle: nil)
    }
    
    func idendifier()->String{
        return "CollectionViewCell"
    }

}
