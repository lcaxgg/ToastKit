//
//  UIButton+Extension.swift
//  ToastKit
//
//  Created by Jayvee on 2/19/26.
//

import UIKit

public extension UIButton {
    func configureButtonText(_ attributes: ToastAttributes) {
        let attributedString = NSMutableAttributedString(string: attributes.buttonText)
        
        attributedString.addAttributes([
            .font: attributes.buttonTextFont as Any,
            .foregroundColor: attributes.foregroundColor as Any,
            .kern: attributes.kern,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ], range: NSRange(location: .zero, length: attributedString.length))
        
        let style = NSMutableParagraphStyle()
        style.alignment = attributes.alignment
        style.lineSpacing = attributes.lineSpacing
        
        attributedString.addAttribute(
            .paragraphStyle,
            value: style,
            range: NSRange(location: .zero, length: attributedString.length)
        )
        
        setAttributedTitle(attributedString as NSAttributedString, for: .normal)
    }
}
