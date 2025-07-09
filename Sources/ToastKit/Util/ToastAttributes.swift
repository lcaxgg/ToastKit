//
//  ToastAttributes.swift
//  ToastKit
//
//  Created by Jayvee on 7/9/25.
//

import UIKit

public struct ToastAttributes {
    let contentTopPadding: CGFloat
    let contentBottomPadding: CGFloat
    let contentLeadingPadding: CGFloat
    let contentTrailingPadding: CGFloat
    let containerLeadingPadding: CGFloat
    let containerTrailingPadding: CGFloat
    let cornerRadius: CGFloat
    
    let backgroundColor: UIColor
    let foregroundColor: UIColor
   
    let title: String?
    let message: String
    let titleFont: UIFont
    let messageFont: UIFont
    let titleMessageSpacing: CGFloat
    
    let buttonText: String
    let buttonTextFont: UIFont
    let showButton: Bool
    
    let position: ToastPosition
    let positionOffset: CGFloat
    
    let duration: TimeInterval
    let deadline: CGFloat
    
    public init(
        contentTopPadding: CGFloat,
        contentBottomPadding: CGFloat,
        contentLeadingPadding: CGFloat,
        contentTrailingPadding: CGFloat,
        containerLeadingPadding: CGFloat,
        containerTrailingPadding: CGFloat,
        cornerRadius: CGFloat,
        backgroundColor: UIColor,
        foregroundColor: UIColor,
        title: String?,
        message: String,
        titleFont: UIFont,
        messageFont: UIFont,
        titleMessageSpacing: CGFloat,
        buttonText: String,
        buttonTextFont: UIFont,
        showButton: Bool,
        position: ToastPosition,
        positionOffset: CGFloat,
        duration: TimeInterval,
        deadline: CGFloat
    ) {
        self.contentTopPadding = contentTopPadding
        self.contentBottomPadding = contentBottomPadding
        self.contentLeadingPadding = contentLeadingPadding
        self.contentTrailingPadding = contentTrailingPadding
        self.containerLeadingPadding = containerLeadingPadding
        self.containerTrailingPadding = containerTrailingPadding
        self.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.title = title
        self.message = message
        self.titleFont = titleFont
        self.messageFont = messageFont
        self.titleMessageSpacing = titleMessageSpacing
        self.buttonText = buttonText
        self.buttonTextFont = buttonTextFont
        self.showButton = showButton
        self.position = position
        self.positionOffset = positionOffset
        self.duration = duration
        self.deadline = deadline
    }
}
