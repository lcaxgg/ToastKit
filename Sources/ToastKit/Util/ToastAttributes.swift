//
//  ToastAttributes.swift
//  ToastKit
//
//  Created by Jayvee on 7/9/25.
//

import UIKit

public struct ToastAttributes {
    let tag: Int
    let contentInsets: UIEdgeInsets
    let containerInsets: UIEdgeInsets
    let cornerRadius: CGFloat
    
    let backgroundColor: UIColor
    let foregroundColor: UIColor
    
    let title: String?
    let message: String
    let titleFont: UIFont
    let messageFont: UIFont
    let titleMessageSpacing: CGFloat
    
    let kern: CGFloat
    let minimumLineHeight: CGFloat
    let maximumLineHeight: CGFloat
    let alignment: NSTextAlignment
    let hStackSpacing: CGFloat?
    
    let buttonText: String
    let buttonTextMinimumLineHeight: CGFloat
    let buttonTextMaximumLineHeight: CGFloat
    let buttonTextFont: UIFont
    let showButton: Bool
    let shouldDismissOnButtonTap: Bool
    
    let position: ToastPosition
    var positionOffset: CGFloat
    
    let duration: TimeInterval
    let deadline: CGFloat
    var initialCenter: CGPoint
    
    let stackingToastAttributes: StackingToastAttributes?
    let slideDirection: SlideDirection?
    
    public init(
        tag: Int = 0,
        contentInsets: UIEdgeInsets = UIEdgeInsets(top: 10.0, left: 15.0, bottom: 10.0, right: 15.0),
        containerInsets: UIEdgeInsets = UIEdgeInsets(top: .zero, left: 13.0, bottom: .zero, right: 13.0),
        cornerRadius: CGFloat = 8.0,
        backgroundColor: UIColor = UIColor.colorWithHexString("#3C3C3C"),
        foregroundColor: UIColor = UIColor.white,
        title: String? = "",
        message: String = "",
        titleFont: UIFont = .systemFont(ofSize: 17.0),
        messageFont: UIFont = .systemFont(ofSize: 15.0),
        titleMessageSpacing: CGFloat = .zero,
        buttonText: String = "Button",
        buttonTextMinimumLineHeight: CGFloat? = nil,
        buttonTextMaximumLineHeight: CGFloat? = nil,
        buttonTextFont: UIFont = .systemFont(ofSize: 15.0),
        showButton: Bool = false,
        shouldDismissOnButtonTap: Bool = false,
        kern: CGFloat = .zero,
        minimumLineHeight: CGFloat? = nil,
        maximumLineHeight: CGFloat? = nil,
        lineSpacing: CGFloat? = nil,
        alignment: NSTextAlignment = .left,
        hStackSpacing: CGFloat? = 5.0,
        position: ToastPosition = .bottom,
        positionOffset: CGFloat = .zero,
        duration: TimeInterval = 0.5,
        deadline: CGFloat = 2.0,
        initialCenter: CGPoint = .zero,
        stackingToastAttributes: StackingToastAttributes? = nil,
        slideDirection: SlideDirection = .left
    ) {
        self.tag = tag
        self.contentInsets = contentInsets
        self.containerInsets = containerInsets
        self.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.title = title
        self.message = message
        self.titleFont = titleFont
        self.messageFont = messageFont
        self.titleMessageSpacing = titleMessageSpacing
        self.buttonText = buttonText
        self.buttonTextMinimumLineHeight = buttonTextMinimumLineHeight ?? .zero
        self.buttonTextMaximumLineHeight = buttonTextMaximumLineHeight ?? .zero
        self.buttonTextFont = buttonTextFont
        self.showButton = showButton
        self.shouldDismissOnButtonTap = shouldDismissOnButtonTap
        self.kern = kern
        self.minimumLineHeight = minimumLineHeight ?? .zero
        self.maximumLineHeight = maximumLineHeight ?? .zero
        self.alignment = alignment
        self.hStackSpacing = hStackSpacing
        self.position = position
        self.positionOffset = positionOffset
        self.duration = duration
        self.deadline = deadline
        self.initialCenter = initialCenter
        self.stackingToastAttributes = stackingToastAttributes
        self.slideDirection = slideDirection
    }
}

public struct StackingToastAttributes {
    let initialTag: Int
    let count: Int
    let spacing: CGFloat
    let insertionPosition: StackingToastInsertionPosition
    let shouldSlideOnRemoval: Bool?
    let nextDismissalDeadline: CGFloat

    public init(
        initialTag: Int = 8000,
        count: Int = 3,
        spacing: CGFloat = 8,
        insertionPosition: StackingToastInsertionPosition = .bottom,
        shouldSlideOnRemoval: Bool? = false,
        nextDismissalDeadline: CGFloat = 0.05
    ) {
        self.initialTag = initialTag
        self.count = count
        self.spacing = spacing
        self.insertionPosition = insertionPosition
        self.shouldSlideOnRemoval = shouldSlideOnRemoval
        self.nextDismissalDeadline = nextDismissalDeadline
    }
}
