//
//  UILabel+Extension.swift
//  ToastKit
//
//  Created by Jayvee on 2/19/26.
//

import UIKit

public extension UILabel {
    func configureTitle(_ attributes: ToastAttributes) {
        guard let title = attributes.title else { return }
        
        let attributedString = NSMutableAttributedString(string: title)
        
        attributedString.addAttributes([
            .font: attributes.titleFont as Any,
            .foregroundColor: attributes.foregroundColor as Any,
            .kern: attributes.kern
        ], range: NSRange(location: 0, length: attributedString.length))
        
        let style = NSMutableParagraphStyle()
        style.alignment = attributes.alignment
        style.lineSpacing = attributes.lineSpacing
        
        attributedString.addAttribute(
            .paragraphStyle,
            value: style,
            range: NSRange(location: 0, length: attributedString.length)
        )
        
        attributedText = attributedString as NSAttributedString
    }
    
    func configureMessage(_ attributes: ToastAttributes) {
        let attributedString = NSMutableAttributedString(string: attributes.message)
        
        attributedString.addAttributes([
            .font: attributes.messageFont as Any,
            .foregroundColor: attributes.foregroundColor as Any,
            .kern: attributes.kern
        ], range: NSRange(location: 0, length: attributedString.length))
        
        let style = NSMutableParagraphStyle()
        style.alignment = attributes.alignment
        style.lineSpacing = attributes.lineSpacing
        
        attributedString.addAttribute(
            .paragraphStyle,
            value: style,
            range: NSRange(location: 0, length: attributedString.length)
        )
        
        attributedText = attributedString as NSAttributedString
    }
}
