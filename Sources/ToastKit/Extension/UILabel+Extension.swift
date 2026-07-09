//
//  UILabel+Extension.swift
//  ToastKit
//
//  Created by Jayvee on 2/19/26.
//

import UIKit

public extension UILabel {
    func configureTitle(_ attributes: ToastAttributes) {
        let attributedString = NSMutableAttributedString(string: attributes.text.title.value)
        
        attributedString.addAttributes([
            .font: attributes.text.title.font as Any,
            .foregroundColor: attributes.text.title.foregroundColor as Any,
            .kern: attributes.text.title.kern
        ], range: NSRange(location: .zero, length: attributedString.length))
        
        let style = NSMutableParagraphStyle()
        style.alignment = attributes.text.title.alignment
        style.minimumLineHeight = attributes.text.title.minimumLineHeight
        style.maximumLineHeight = attributes.text.title.maximumLineHeight
        
        attributedString.addAttribute(
            .paragraphStyle,
            value: style,
            range: NSRange(location: .zero, length: attributedString.length)
        )
        
        attributedText = attributedString as NSAttributedString
    }
    
    func configureMessage(_ attributes: ToastAttributes) {
        let attributedString = NSMutableAttributedString(string: attributes.text.message.value)
        
        attributedString.addAttributes([
            .font: attributes.text.message.font as Any,
            .foregroundColor: attributes.text.message.foregroundColor as Any,
            .kern: attributes.text.message.kern
        ], range: NSRange(location: .zero, length: attributedString.length))
        
        let style = NSMutableParagraphStyle()
        style.alignment = attributes.text.message.alignment
        style.minimumLineHeight = attributes.text.message.minimumLineHeight
        style.maximumLineHeight = attributes.text.message.maximumLineHeight
        style.lineBreakMode =  .byTruncatingTail
        
        attributedString.addAttribute(
            .paragraphStyle,
            value: style,
            range: NSRange(location: .zero, length: attributedString.length)
        )
        
        numberOfLines = attributes.text.message.numberOfLines
        attributedText = attributedString as NSAttributedString
    }
}
