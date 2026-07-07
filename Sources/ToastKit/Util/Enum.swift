//
//  Enum.swift
//  ToastKit
//
//  Created by Jayvee on 7/9/25.
//

import UIKit

// MARK: - Position

public enum ToastPosition {
    case top
    case center
    case bottom
}

public enum StackingToastInsertionPosition {
    case top
    case bottom
}

public enum SlideDirection {
    case left
    case right

    var multiplier: CGFloat {
        switch self {
        case .left:
            return -1
        case .right:
            return 1
        }
    }
}

// MARK: - Tag

public enum StackingToastContentTag {
    static let title = 9001
    static let message = 9002
    static let button = 9003
}
