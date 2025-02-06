//
//  SectionHeader.swift
//  appdev
//
//  Created by JIDTP1408 on 30/01/25.
//

import UIKit

class SectionHeader: UICollectionReusableView {

    
    @IBOutlet weak var headerLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
               headerLbl.translatesAutoresizingMaskIntoConstraints = false
               headerLbl.font = UIFont.boldSystemFont(ofSize: 18)
               headerLbl.textColor = .black
               addSubview(headerLbl)
               
               NSLayoutConstraint.activate([
                   headerLbl.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                   headerLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                   headerLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                   headerLbl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
               ])


    }
    
        
    func configure(with title: String) {
        headerLbl.text = title
    }
    
    func NibName()-> UINib{
        return UINib(nibName: "SectionHeader", bundle: nil)
    }
    
    func identy()->String{
        return "SectionHeader"
    }
    
    
}
