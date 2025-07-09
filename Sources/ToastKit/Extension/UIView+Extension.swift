//
//  UIView+Extension.swift
//  ToastKit
//
//  Created by Jayvee on 7/9/25.
//

import UIKit

extension UIView {
    func showToastMessage(
        with attributes: ToastAttributes,
        onButtonTap buttonAction: (() -> Void)? = nil
    ) {
        let toast = ToastView(with: attributes)
        addSubview(toast)
        
        toast.setConstraints(in: self)
        toast.animateWith(duration: attributes.duration, deadline: attributes.deadline)
        
        toast.onButtonTap = {
            buttonAction?()
        }
    }
}

