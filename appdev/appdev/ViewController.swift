//
//  ViewController.swift
//  appdev
//
//  Created by JIDTP1408 on 23/01/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        indicator()
    }

    func indicator(){
        // Show loading indicator with a custom message
        LoadingIndicator.shared.show(on: self.view, message: "Fetching data...")
        
        // Simulate a delay and hide loading indicator
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            LoadingIndicator.shared.hide()
        }
    }

     
}

