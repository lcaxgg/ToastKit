//
//  UIButton+Extension.swift
//  ToastKit
//
//  Created by Jayvee on 2/19/26.
//

import UIKit

public extension UIButton {
    func configureButtonText(_ attributes: ToastAttributes) {
        let attributedString = NSMutableAttributedString(string: attributes.button.text)
        
        attributedString.addAttributes([
            .font: attributes.button.font as Any,
            .foregroundColor: attributes.button.foregroundColor as Any,
            .kern: attributes.button.kern,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ], range: NSRange(location: .zero, length: attributedString.length))
        
        let style = NSMutableParagraphStyle()
        style.alignment = attributes.button.alignment
        style.minimumLineHeight = attributes.button.maximumLineHeight
        style.maximumLineHeight = attributes.button.maximumLineHeight
        
        attributedString.addAttribute(
            .paragraphStyle,
            value: style,
            range: NSRange(location: .zero, length: attributedString.length)
        )
        
        setAttributedTitle(attributedString as NSAttributedString, for: .normal)
    }
}
