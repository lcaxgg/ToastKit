//
//  ToastAttributes.swift
//  ToastKit
//
//  Created by Jayvee on 7/9/25.
//

import UIKit

// MARK: - toast

public struct ToastAttributes {

    let tag: Int

    let layout: ToastLayoutAttributes
    let appearance: ToastAppearanceAttributes
    public var text: ToastTextAttributes
    let button: ToastButtonAttributes
    let animation: ToastAnimationAttributes
    let timing: ToastTimingAttributes
    var position: ToastPositionAttributes

    let stacking: StackingToastAttributes?

    public init(
        tag: Int = 0,
        layout: ToastLayoutAttributes = .init(),
        appearance: ToastAppearanceAttributes = .init(),
        text: ToastTextAttributes = .init(),
        button: ToastButtonAttributes = .init(),
        animation: ToastAnimationAttributes = .init(),
        timing: ToastTimingAttributes = .init(),
        position: ToastPositionAttributes = .init(),
        stacking: StackingToastAttributes? = nil
    ) {
        self.tag = tag
        self.layout = layout
        self.appearance = appearance
        self.text = text
        self.button = button
        self.animation = animation
        self.timing = timing
        self.position = position
        self.stacking = stacking
    }
}

// MARK: - layout

public struct ToastLayoutAttributes {

    let contentInsets: UIEdgeInsets
    let containerInsets: UIEdgeInsets
    let cornerRadius: CGFloat
    let titleMessageSpacing: CGFloat
    let hStackSpacing: CGFloat?

    public init(
        contentInsets: UIEdgeInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15),
        containerInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 13, bottom: 0, right: 13),
        cornerRadius: CGFloat = 8,
        titleMessageSpacing: CGFloat = 0,
        hStackSpacing: CGFloat? = 5
    ) {
        self.contentInsets = contentInsets
        self.containerInsets = containerInsets
        self.cornerRadius = cornerRadius
        self.titleMessageSpacing = titleMessageSpacing
        self.hStackSpacing = hStackSpacing
    }
}

// MARK: - appearance

public struct ToastAppearanceAttributes {

    let backgroundColor: UIColor
    let foregroundColor: UIColor

    public init(
        backgroundColor: UIColor = UIColor.colorWithHexString("#3C3C3C"),
        foregroundColor: UIColor = .white
    ) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
    }
}

// MARK: - text

public struct ToastTextAttributes {

    public var title: ToastLabelAttributes
    public var message: ToastLabelAttributes

    public init(
        title: ToastLabelAttributes = .init(
            font: .systemFont(ofSize: 17)
        ),
        message: ToastLabelAttributes = .init(
            font: .systemFont(ofSize: 15)
        )
    ) {
        self.title = title
        self.message = message
    }
}

public struct ToastLabelAttributes {

    public var value: String

    let font: UIFont
    let foregroundColor: UIColor

    let kern: CGFloat
    let alignment: NSTextAlignment
    let lineBreakMode: NSLineBreakMode
    let numberOfLines: Int
    let minimumLineHeight: CGFloat
    let maximumLineHeight: CGFloat

    public init(
        value: String = "",
        font: UIFont = .systemFont(ofSize: 15),
        foregroundColor: UIColor = .white,
        kern: CGFloat = 0,
        alignment: NSTextAlignment = .left,
        lineBreakMode: NSLineBreakMode = .byWordWrapping,
        numberOfLines: Int = 0,
        minimumLineHeight: CGFloat = 0,
        maximumLineHeight: CGFloat = 0
    ) {
        self.value = value
        self.font = font
        self.foregroundColor = foregroundColor
        self.kern = kern
        self.alignment = alignment
        self.lineBreakMode = lineBreakMode
        self.numberOfLines = numberOfLines
        self.minimumLineHeight = minimumLineHeight
        self.maximumLineHeight = maximumLineHeight
    }
}

// MARK: - button

public struct ToastButtonAttributes {

    let text: String

    let font: UIFont
    let foregroundColor: UIColor
    let backgroundColor: UIColor

    let kern: CGFloat
    let alignment: NSTextAlignment
    let minimumLineHeight: CGFloat
    let maximumLineHeight: CGFloat

    let isVisible: Bool
    let dismissOnTap: Bool

    public init(
        text: String = "Button",
        font: UIFont = .systemFont(ofSize: 15),
        foregroundColor: UIColor = .white,
        backgroundColor: UIColor = .clear,
        kern: CGFloat = 0,
        alignment: NSTextAlignment = .center,
        minimumLineHeight: CGFloat = 0,
        maximumLineHeight: CGFloat = 0,
        isVisible: Bool = false,
        dismissOnTap: Bool = false
    ) {
        self.text = text
        self.font = font
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.kern = kern
        self.alignment = alignment
        self.minimumLineHeight = minimumLineHeight
        self.maximumLineHeight = maximumLineHeight
        self.isVisible = isVisible
        self.dismissOnTap = dismissOnTap
    }
}

// MARK: - timing

public struct ToastTimingAttributes {

    let animationDuration: TimeInterval
    let dismissalDeadline: CGFloat

    public init(
        animationDuration: TimeInterval = 0.5,
        dismissalDeadline: CGFloat = 3
    ) {
        self.animationDuration = animationDuration
        self.dismissalDeadline = dismissalDeadline
    }
}

// MARK: - position

public struct ToastPositionAttributes {

    let position: ToastPosition
    var offset: CGFloat
    var initialCenter: CGPoint

    public init(
        position: ToastPosition = .bottom,
        offset: CGFloat = 0,
        initialCenter: CGPoint = .zero
    ) {
        self.position = position
        self.offset = offset
        self.initialCenter = initialCenter
    }
}

// MARK: - animation

public struct ToastAnimationAttributes {

    let slideDirection: SlideDirection?
    public var shouldAnimate: Bool
    
    public init(
        slideDirection: SlideDirection? = .left,
        shouldAnimate: Bool = true
    ) {
        self.slideDirection = slideDirection
        self.shouldAnimate = shouldAnimate
    }
}

// MARK: - stacking

public struct StackingToastAttributes {

    let initialTag: Int
    let count: Int
    let spacing: CGFloat
    let insertionPosition: StackingToastInsertionPosition
    let shouldSlideOnRemoval: Bool
    let nextDismissalDeadline: CGFloat
    let shouldDismissAllOnButtonTap: Bool
    
    public var shouldValidateExistingContent: Bool

    public init(
        initialTag: Int = 8000,
        count: Int = 3,
        spacing: CGFloat = 8,
        insertionPosition: StackingToastInsertionPosition = .bottom,
        shouldSlideOnRemoval: Bool = false,
        shouldDismissAllOnButtonTap: Bool = false,
        nextDismissalDeadline: CGFloat = 0.05,
        shouldValidateExistingContent: Bool = false
    ) {
        self.initialTag = initialTag
        self.count = count
        self.spacing = spacing
        self.insertionPosition = insertionPosition
        self.shouldSlideOnRemoval = shouldSlideOnRemoval
        self.shouldDismissAllOnButtonTap = shouldDismissAllOnButtonTap
        self.nextDismissalDeadline = nextDismissalDeadline
        self.shouldValidateExistingContent = shouldValidateExistingContent
    }
}
