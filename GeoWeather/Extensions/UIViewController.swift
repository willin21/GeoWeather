//
//  UIViewController.swift
//  GeoWeather
//
//  Created by william niño on 30/01/25.
//

import UIKit

extension UIViewController {
    
    func dismissOrPop() {
        if presentingViewController != nil {
            dismiss(animated: true)
        } else if navigationController?.presentingViewController != nil, navigationController?.viewControllers.count == 1 {
            navigationController?.dismiss(animated: true)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    func presentRetryAlert(withTitle title: String,
                           message: String?,
                           completionHandler: ((UIAlertAction) -> ())? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let retryAction = UIAlertAction(title: "Retry", style: .default) { action in
            completionHandler!(action)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(retryAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func showToast(message : String,
                   iconImage: UIImage? = nil,
                   backgroundColor: UIColor? = UIColor.greenDone,
                   alpha: CGFloat = 1.0,
                   textColor: UIColor? = .black
    ) {
        let toastLabel = UILabel(
            frame: CGRect(
                x: self.view.frame.size.width/2 - 150,
                y: self.view.frame.size.height-100,
                width: 300,
                height: 44
            )
        )
        
        if let icon = iconImage {
            let iconImageView = UIImageView(frame: CGRect(x: 10, y: (44 - 20) / 2, width: 20, height: 20))
            iconImageView.image = icon
            iconImageView.contentMode = .center
            toastLabel.addSubview(iconImageView)
        }
        
        toastLabel.backgroundColor = backgroundColor
        toastLabel.textColor = textColor
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = alpha
        toastLabel.layer.cornerRadius = 10;
        toastLabel.numberOfLines = 2
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 6.0, delay: 0.2, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
