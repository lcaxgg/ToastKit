//
//  ToastView.swift
//  ToastKit
//
//  Created by Jayvee on 7/9/25.
//

import UIKit

class ToastView: UIView {
    
    //MARK: - Properties
    
    private var attributes: ToastAttributes!
    var onButtonTap: (() -> Void)?
    
    //MARK: - Initializations
    
    init(with attributesParam: ToastAttributes) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = attributesParam.backgroundColor
        layer.cornerRadius = attributesParam.cornerRadius
        
        attributes = attributesParam
        
        let titleLabel = setupTitleLabel(attributesParam)
        let messageLabel = setupMessageLabel(attributesParam)
        let button = setupButton(attributesParam)
    
        let vStack = UIStackView(arrangedSubviews: [titleLabel, messageLabel])
        vStack.axis = .vertical
        vStack.spacing = attributesParam.titleMessageSpacing
        
        var subView: UIView? = nil
        
        if attributesParam.showButton {
            let hStack = UIStackView(arrangedSubviews: [vStack, button])
            hStack.axis = .horizontal
            hStack.alignment = .center
            
            subView = hStack
        } else {
            subView = vStack
        }
        
        guard let subView else { return }
       
        addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subView.topAnchor.constraint(equalTo: topAnchor, constant: attributesParam.contentInsets.top),
            subView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -attributesParam.contentInsets.bottom),
            subView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: attributesParam.contentInsets.left),
            subView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -attributesParam.contentInsets.right)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Setup

private extension ToastView {
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
    
    func setupButton(_ attributes: ToastAttributes) -> UIButton {
        let button = UIButton(type: .system)
        button.tintColor = attributes.foregroundColor
        button.addTarget(nil, action: #selector(buttonTapped), for: .touchUpInside)
        button.setContentHuggingPriority(.required, for: .horizontal)
        button.setContentCompressionResistancePriority(.required, for: .horizontal)
        button.configureButtonText(attributes)
        return button
    }
}

//MARK: - Public method/s

extension ToastView {
    func setConstraints(in view: UIView) {
        // Determine bottom offset based on safe area insets
        let bottomInset = view.safeAreaInsets.bottom
        let bottomOffset = (bottomInset > 0 ? -attributes.positionOffset : -(attributes.positionOffset + 16))

        // Apply bottom constraint relative to view.bottomAnchor
        let bottomConstraint = bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: bottomOffset)

        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: attributes.containerInsets.left),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -attributes.containerInsets.right),
            bottomConstraint
        ])
    }
    
    func animateWith(duration: TimeInterval, deadline: CGFloat) {
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
                }
            }
        }
      }
}

//MARK: - Private method/s

private extension ToastView {}

//MARK: - Action/s

extension ToastView {
    @objc private func buttonTapped() {
        onButtonTap?()
    }
}
