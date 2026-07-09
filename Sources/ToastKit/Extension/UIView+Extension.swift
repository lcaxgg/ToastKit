//
//  UIView+Extension.swift
//  ToastKit
//
//  Created by Jayvee on 7/9/25.
//

import UIKit

public extension UIView {
    func pinToEdges(
        of view: UIView,
        insets: UIEdgeInsets = .zero
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -insets.right),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom)
        ])
    }
    
    func setCustomWidth(_ width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func setCustomHeight(_ height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
}

public extension UIView {
    func showToastMessage(
        with attributes: ToastAttributes,
        onButtonTap buttonAction: (() -> Void)? = nil,
        onDismiss dismissAction: (() -> Void)? = nil
    ) {
        let toast = ToastView(with: attributes)
        addSubview(toast)
        
        toast.setConstraints(in: self)
        toast.animateWith(duration: attributes.timing.animationDuration, deadline: attributes.timing.dismissalDeadline)
        
        toast.onButtonTap = {
            buttonAction?()
        }
        
        toast.onDismiss = {
            dismissAction?()
        }
    }
}
