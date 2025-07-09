# ToastKit 🚀🔥

**A customizable 🍞 toast notification library for iOS, built with Swift!**

---

## ✨ Features

- Show beautiful toast messages in your app!
- Highly customizable: colors, fonts, padding, corner radius, button, and more 🎨
- Supports positioning: top, center, or bottom 🧭
- Add a button for user interaction (optional) 🖱️
- Easy animation and auto-dismissal ⏰
- Built with UIKit, supports iOS 15+ 📱

---

## ⚡️ Installation

Add ToastKit to your project using Swift Package Manager:

```swift
dependencies: [
    .package(url: "https://github.com/lcaxgg/ToastKit.git", from: "1.0.0")
]
```

Or use Xcode:

1. Go to **File > Add Packages...**
2. Enter: `https://github.com/lcaxgg/ToastKit`
3. Add the package to your project!

---

## 🛠️ Usage

You can easily extend `ToastAttributes` to create your own custom initializer for more streamlined usage!

```swift
import ToastKit

extension ToastAttributes {
    static func customInit(
        contentTopPadding: CGFloat = 0,
        contentBottomPadding: CGFloat = 0,
        contentLeadingPadding: CGFloat = 0,
        contentTrailingPadding: CGFloat = 0,
        containerLeadingPadding: CGFloat = 0,
        containerTrailingPadding: CGFloat = 0,
        cornerRadius: CGFloat = 0,
        backgroundColor: UIColor = .black,
        foregroundColor: UIColor = .white,
        titleMessageSpacing: CGFloat = 0,
        title: String? = nil,
        message: String,
        showViewButton: Bool = false,
        titleFont: UIFont = UIFont.systemFont(ofSize: 0, weight: .bold),
        messageFont: UIFont = UIFont.systemFont(ofSize: 0),
        buttonText: String = "Button",
        buttonTextFont: UIFont = UIFont.systemFont(ofSize: 0),
        position: ToastPosition = .bottom,
        positionOffset: CGFloat = 0
    ) -> ToastAttributes {
        return ToastAttributes(
            contentTopPadding: contentTopPadding,
            contentBottomPadding: contentBottomPadding,
            contentLeadingPadding: contentLeadingPadding,
            contentTrailingPadding: contentTrailingPadding,
            containerLeadingPadding: containerLeadingPadding,
            containerTrailingPadding: containerTrailingPadding,
            cornerRadius: cornerRadius,
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            title: title,
            message: message,
            titleFont: titleFont,
            messageFont: messageFont,
            titleMessageSpacing: titleMessageSpacing,
            buttonText: buttonText,
            buttonTextFont: buttonTextFont,
            showViewButton: showViewButton,
            position: position,
            positionOffset: positionOffset
        )
    }
}
```

Here’s how you can use your custom initializer to show a toast:

```swift
@objc private func showToast() {
    let attributes = ToastAttributes.customInit(
        title: "Title here",
        message: "message here",
        showViewButton: true
    )
    
    let toast = ToastView(with: attributes)
   
    view.addSubview(toast)
    toast.setConstraints(in: view)
    toast.animateWith(duration: 0.2, deadline: 1.5)
    toast.onButtonTap = {
        print("Button tapped!")
    }
}
```

---

## 🖼️ Sample Screenshots

| Simple Toast                                 | Toast with Button                             |
|:---------------------------------------------:|:---------------------------------------------:|
| <img width="346" alt="Screenshot 2025-07-09 at 5 05 03 PM" src="https://github.com/user-attachments/assets/9857012c-97f7-4535-ad78-730fce3d41ad" /> | <img width="341" alt="Screenshot 2025-07-09 at 5 05 26 PM" src="https://github.com/user-attachments/assets/a5325d56-e855-4567-982a-45f00dfbb726" /> |


