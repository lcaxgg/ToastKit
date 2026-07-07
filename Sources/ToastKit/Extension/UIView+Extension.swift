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
    
    func setWidth(_ width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func setHeight(_ height: CGFloat) {
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
        toast.animateWith(duration: attributes.duration, deadline: attributes.deadline)
        
        toast.onButtonTap = {
            buttonAction?()
        }
        
        toast.onDismiss = {
            dismissAction?()
        }
    }
    
    func showStackingToastMessage(
        with attributes: ToastAttributes,
        onButtonTap buttonAction: (() -> Void)? = nil,
        onDismiss dismissAction: (() -> Void)? = nil
    ) {
        let toast = StackingToastView(with: attributes)
        addSubview(toast)
        
        toast.setConstraints(in: self)
        toast.animateWith(duration: attributes.duration, deadline: attributes.deadline)
        
        toast.onButtonTap = {
            buttonAction?()
        }
        
//        toast.onDismiss = {
//            dismissAction?()
//        }
    }
}
