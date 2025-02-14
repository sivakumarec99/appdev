//
//  UIViewController+Ectention.swift
//  appdev
//
//  Created by JIDTP1408 on 14/02/25.
//

import Foundation

import UIKit

extension UIViewController {
    
    /// Navigates to a specified view controller using push or modal presentation.
    /// - Parameters:
    ///   - viewController: The destination view controller.
    ///   - presentationStyle: Determines whether to push or present the view controller.
    ///   - animated: Animation flag.
    func navigate(to viewController: UIViewController, presentationStyle: NavigationType, animated: Bool = true) {
        switch presentationStyle {
        case .push:
            if let navigationController = self.navigationController {
                navigationController.pushViewController(viewController, animated: animated)
            } else {
                print("⚠️ No Navigation Controller Found: Falling back to modal presentation")
                present(viewController, animated: animated, completion: nil)
            }
            
        case .present(let modalPresentationStyle):
            viewController.modalPresentationStyle = modalPresentationStyle
            present(viewController, animated: animated, completion: nil)
        }
    }
}

/// Enum for Navigation Type
enum NavigationType {
    case push
    case present(UIModalPresentationStyle)
}
