//
//  StackingToastView.swift
//  ToastKit
//
//  Created by Jayvee on 7/6/26.
//

import UIKit

public class StackingToastView: UIView {
    
    //MARK: - Properties
    
    public var attributes: ToastAttributes!
    private var dismissWorkItem: DispatchWorkItem?
    public var onDismiss: ((_ didRemoveAllToasts: Bool) -> Void)?
    
    var vStack: UIStackView = {
        let hStack = UIStackView()
        hStack.axis = .vertical
        hStack.translatesAutoresizingMaskIntoConstraints = false
        return hStack
    }()
    
    //MARK: - Initializations
    
    public init(with attributesParam: ToastAttributes) {
        super.init(frame: .zero)
        tag = attributesParam.stackingToastAttributes?.initialTag ?? .zero
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        
        attributes = attributesParam
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Configuration

extension StackingToastView {
    public static func make(
        in view: UIView,
        attributes: ToastAttributes
    ) -> StackingToastView {
        
        let toast = StackingToastView(with: attributes)
        
        view.addSubview(toast)
        toast.setConstraints(in: view)
        
        return toast
    }
    
    public func addToast(
        onButtonTap: (() -> Void)? = nil
    ) {
        if vStack.arrangedSubviews.count >= 3 {
            guard let lastToast = vStack.arrangedSubviews.last else { return }
            updateToast(lastToast)
            
            resetDismissTimer(
                duration: attributes.duration,
                deadline: attributes.deadline
            )
            return
        }
        
        let bgView = setupBgView(onButtonTap: onButtonTap)
        
        let pan = UIPanGestureRecognizer(
            target: self,
            action: #selector(handlePan(_:))
        )
        
        bgView.addGestureRecognizer(pan)
        
        switch attributes.stackingToastAttributes?.insertionPosition {
        case .top:
            vStack.insertArrangedSubview(bgView, at: 0)
        case .bottom, .none:
            vStack.addArrangedSubview(bgView)
        }
        
        animateAddedToast(
            bgView,
            duration: attributes.duration,
            deadline: attributes.deadline
        )
    }
    
    private func updateToast(_ toast: UIView) {
        (toast.viewWithTag(StackingToastContentTag.title) as? UILabel)?.text = attributes.title
        (toast.viewWithTag(StackingToastContentTag.message) as? UILabel)?.text = attributes.message
    }
}

//MARK: - Setup

private extension StackingToastView {
    func setupUI() {
        setupVStack()
    }
    
    func setupVStack() {
        addSubview(vStack)
        vStack.pinToEdges(of: self)
        vStack.spacing = attributes.stackingToastAttributes?.spacing ?? .zero
    }
    
    func setupBgView(
        onButtonTap: (() -> Void)?
    ) -> UIView {
        let view = UIView()
        view.tag = attributes.stackingToastAttributes?.initialTag ?? .zero
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = attributes.backgroundColor
        view.layer.cornerRadius = attributes.cornerRadius
        view.setCustomWidth(layer.frame.width)
        
        let titleLabel = setupTitleLabel(attributes)
        titleLabel.tag = StackingToastContentTag.title
        
        let messageLabel = setupMessageLabel(attributes)
        messageLabel.tag = StackingToastContentTag.message
        
        let button = setupButton(view, attributes, onButtonTap)
        button.tag = StackingToastContentTag.button
        
        let vStack = UIStackView(arrangedSubviews: [titleLabel, messageLabel])
        vStack.axis = .vertical
        vStack.spacing = attributes.titleMessageSpacing
        
        var subView: UIView? = nil
        
        if attributes.showButton {
            let hStack = UIStackView(arrangedSubviews: [vStack, button])
            hStack.axis = .horizontal
            hStack.alignment = .center
            hStack.spacing = attributes.hStackSpacing ?? .zero
            
            subView = hStack
        } else {
            subView = vStack
        }
        
        guard let subView else { return view }
        
        view.addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subView.topAnchor.constraint(equalTo: view.topAnchor, constant: attributes.contentInsets.top),
            subView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -attributes.contentInsets.bottom),
            subView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: attributes.contentInsets.left),
            subView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -attributes.contentInsets.right)
        ])
        
        return view
    }
    
    func setupTitleLabel(_ attributes: ToastAttributes) -> UILabel {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = .zero
        titleLabel.configureTitle(attributes)
        return titleLabel
    }
    
    func setupMessageLabel(_ attributes: ToastAttributes) -> UILabel {
        let messageLabel = UILabel()
        messageLabel.numberOfLines = .zero
        messageLabel.configureMessage(attributes)
        return messageLabel
    }
    
    private func setupButton(
        _ view: UIView,
        _ attributes: ToastAttributes,
        _ onButtonTap: (() -> Void)?
    ) -> UIButton {
        let button = UIButton(type: .system)
        
        button.tintColor = attributes.foregroundColor
        button.setContentHuggingPriority(.required, for: .horizontal)
        button.setContentCompressionResistancePriority(.required, for: .horizontal)
        button.configureButtonText(attributes)
        
        if #available(iOS 14.0, *) {
            button.addAction(
                UIAction { _ in
                    onButtonTap?()
                    
                    self.resetDismissTimer(
                        duration: attributes.duration,
                        deadline: attributes.deadline
                    )
                    
                    if attributes.shouldDismissOnButtonTap {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                            guard let self else { return }
                            
                            self.vStack.removeArrangedSubview(view)
                            view.removeFromSuperview()
                            
                            if self.vStack.arrangedSubviews.isEmpty {
                                self.removeFromSuperview()
                                self.onDismiss?(true)
                            }
                        }
                    }
                },
                for: .touchUpInside
            )
        } else {
            // Use your existing target/action approach if you support iOS 13
        }
        
        return button
    }
}

//MARK: - Public method/s

extension StackingToastView {
    public func setConstraints(in view: UIView) {
        let bottomInset = view.safeAreaInsets.bottom
        let bottomOffset = (bottomInset > 0 ? -attributes.positionOffset : -(attributes.positionOffset + 16))
        
        if attributes.containerInsets == .zero {
            centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        } else {
            leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: attributes.containerInsets.left).isActive = true
            trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -attributes.containerInsets.right).isActive = true
        }
        
        bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: bottomOffset).isActive = true
    }
    
    func animateWith(
        duration: TimeInterval,
        deadline: CGFloat
    ) {
        alpha = 0
        
        UIView.animate(withDuration: duration, animations: { [weak self] in
            guard let self = self else { return }
            self.alpha = 1
        }) { [weak self] _ in
            guard let self = self else { return }
            
            // Wait for `deadline` seconds, then fade out
            DispatchQueue.main.asyncAfter(deadline: .now() + deadline) { [weak self] in
                guard let self = self else { return }
                
                // Fade Out
                UIView.animate(withDuration: duration, animations: {
                    self.alpha = 0
                }) { _ in
                    self.removeFromSuperview()
                    self.onDismiss?(false)
                }
            }
        }
    }
}

//MARK: - Private method/s

private extension StackingToastView {
    private func animateAddedToast(
        _ view: UIView,
        duration: TimeInterval,
        deadline: CGFloat
    ) {
        // Cancel any pending dismissal since a new toast was added
        dismissWorkItem?.cancel()
        
        view.alpha = 0
        
        UIView.animate(withDuration: duration, animations: {
            view.alpha = 1
        }) { _ in
            self.resetDismissTimer(
                duration: duration,
                deadline: deadline
            )
        }
    }
    
    private func dismiss(view: UIView, direction: CGFloat) {
        guard let superview = view.superview else { return }
        
        let targetX = direction > 0
        ? superview.bounds.width * 1.5
        : -superview.bounds.width * 1.5
        
        UIView.animate(withDuration: 0.25, animations: {
            view.center.x = targetX
            view.alpha = 0
        }) { _ in
            self.vStack.removeArrangedSubview(view)
            view.removeFromSuperview()
            
            if self.vStack.arrangedSubviews.isEmpty {
                self.removeFromSuperview()
                self.onDismiss?(true)
            }
        }
    }
    
    private func resetDismissTimer(
        duration: TimeInterval,
        deadline: CGFloat
    ) {
        dismissWorkItem?.cancel()
        
        let workItem = DispatchWorkItem { [weak self] in
            guard let self else { return }
            
            guard let view = self.vStack.arrangedSubviews.first else { return }
            
            if attributes.stackingToastAttributes?.shouldSlideOnRemoval == true {
                self.removeToastSliding(view, duration)
            } else {
                self.removeToastFading(view, duration)
            }
        }
        
        dismissWorkItem = workItem
        
        DispatchQueue.main.asyncAfter(
            deadline: .now() + deadline,
            execute: workItem
        )
    }
    
    private func removeToastSliding(
        _ view: UIView,
        _ duration: TimeInterval
    ) {
        guard
            let superview = view.superview,
            let slideDirection = attributes.slideDirection
        else {
            return
        }
        
        let targetX: CGFloat = slideDirection == .left
        ? -superview.bounds.width * 1.5
        : superview.bounds.width * 1.5
        
        UIView.animate(withDuration: duration, animations: {
            view.center.x = targetX
            view.alpha = 0
        }) { _ in
            self.finishRemovingToast(view, duration)
        }
    }
    
    private func removeToastFading(
        _ view: UIView,
        _ duration: TimeInterval
    ) {
        UIView.animate(withDuration: duration, animations: {
            view.alpha = 0
        }) { _ in
            self.finishRemovingToast(view, duration)
        }
    }
    
    private func finishRemovingToast(
        _ view: UIView,
        _ duration: TimeInterval
    ) {
        vStack.removeArrangedSubview(view)
        view.removeFromSuperview()
        
        if vStack.arrangedSubviews.isEmpty {
            removeFromSuperview()
            onDismiss?(true)
        } else {
            onDismiss?(false)
            
            // Schedule dismissal of the next toast
            resetDismissTimer(
                duration: duration,
                deadline: attributes.stackingToastAttributes?.nextDismissalDeadline ?? 0.05
            )
        }
    }
}

//MARK: - Action/s

extension StackingToastView {
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard
            let view = gesture.view,
            let superview = view.superview
        else {
            return
        }
        
        let translation = gesture.translation(in: superview)
        
        switch gesture.state {
        case .began:
            attributes.initialCenter = view.center
            view.layer.removeAllAnimations()
        case .changed:
            view.center = CGPoint(
                x: attributes.initialCenter.x + translation.x,
                y: attributes.initialCenter.y
            )
            
            let progress = abs(translation.x) / superview.bounds.width
            view.alpha = 1 - progress
        case .ended, .cancelled:
            let velocity = gesture.velocity(in: superview).x
            let shouldDismiss = abs(translation.x) > 100 || abs(velocity) > 500
            
            if shouldDismiss {
                dismiss(view: view, direction: translation.x)
            } else {
                UIView.animate(withDuration: 0.2) {
                    view.center = self.attributes.initialCenter
                    view.alpha = 1
                }
            }
        default:
            break
        }
    }
}
