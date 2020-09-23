//
//  ErrorActionSheetExtension.swift
//  Reddit36
//
//  Created by Shean Bjoralt on 9/23/20.
//  Copyright © 2020 Shean Bjoralt. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentErrorToUser(localizedError: LocalizedError) {
        let alertController = UIAlertController(title: "Error", message: localizedError.errorDescription, preferredStyle: .actionSheet)
        
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        
        alertController.addAction(dismissAction)
        present(alertController, animated: true)
    }
}
