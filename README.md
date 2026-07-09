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

## 🛠️ Single toast usage

```swift
let attributes = ToastAttributes(
    layout: .init(contentInsets: UIEdgeInsets(top: 12.5, left: 15.0, bottom: 12.5, right: 15.0),
                  hStackSpacing: 16),
            
    text: .init(message: .init(value: "message here",
                              font: UIFont.systemFont(ofSize: 14),
                              kern: 0.2,
                              lineBreakMode: .byTruncatingTail,
                              numberOfLines: 2,
                              minimumLineHeight: 19,
                              maximumLineHeight: 19)),
            
    button: .init(text: "Button text here",
                  font: UIFont.systemFont(ofSize: 13),
                  minimumLineHeight: 19,
                  maximumLineHeight: 19,
                  isVisible: true),
            
    timing: .init(animationDuration: 0.2,
                  dismissalDeadline: 3)
)

view.showToastMessage(
    with: attributes,
    onButtonTap: {
        // do some thing here
    },
    onDismiss: {
        // do some thing here
    }
)
```
---

## 🖼️ Sample Screenshots

<table>
  <tr>
    <th style="text-align:center">Simple Toast</th>
    <th style="text-align:center">Toast with Button</th>
  </tr>
  <tr>
    <td align="center">
      <img width="346" alt="Screenshot 2025-07-09 at 5 05 03 PM" src="https://github.com/user-attachments/assets/9857012c-97f7-4535-ad78-730fce3d41ad" />
    </td>
    <td align="center">
      <img width="341" alt="Screenshot 2025-07-09 at 5 05 26 PM" src="https://github.com/user-attachments/assets/a5325d56-e855-4567-982a-45f00dfbb726" />
    </td>
  </tr>
</table>

---

## 🛠️ Stacking toast usage

```swift
private var stackingToast: StackingToastView?

func showStackingToast(message: String) {
    if stackingToast == nil {
        let attributes = ToastAttributes(
            layout: .init(contentInsets: UIEdgeInsets(top: 12.5, left: 15, bottom: 12.5, right: 15),
                          hStackSpacing: 16),
            
            text: .init(message: .init(value: message,
                                       font: UIFont.systemFont(ofSize: 15),
                                       kern: 0.2,
                                       lineBreakMode: .byTruncatingTail,
                                       numberOfLines: 2,
                                       minimumLineHeight: 19,
                                       maximumLineHeight: 19)),
            
            button: .init(text: "View",
                          font: UIFont.systemFont(ofSize: 13.5),
                          minimumLineHeight: 19,
                          maximumLineHeight: 19,
                          isVisible: true),
            
            timing: .init(animationDuration: 0.2,
                          dismissalDeadline: 3),
            
            stacking: .init(count: 3,
                            shouldSlideOnRemoval: true,
                            shouldDismissAllOnButtonTap: true)
        )
        
        stackingToast = StackingToastView.make(
            in: view,
            attributes: attributes
        )
    } else {
        stackingToast?.attributes.text.message.value = message
    }
    
    stackingToast?.addToast(onButtonTap: {
        // do some thing here
    })
    
    stackingToast?.onDismiss = { [weak self] didRemoveAllToasts in
        guard didRemoveAllToasts else { return }
        self?.stackingToast = nil
    }
}

showStackingToast(message: "dynamic value")
```
---

## 🖼️ Sample Screenshots

<table>
  <tr>
    <th style="text-align:center">Truncated</th>
    <th style="text-align:center">Full</th>
  </tr>
  <tr>
    <td align="center">
     <img width="1320" height="682" alt="Simulator Screenshot - ip16 pmx - 2026-07-09 at 14 48 51" src="https://github.com/user-attachments/assets/6f09acfb-b1ec-46e7-855b-38b199a9bab7" />
    </td>
    <td align="center">
     <img width="1320" height="1436" alt="Simulator Screenshot - ip16 pmx - 2026-07-09 at 14 49 13" src="https://github.com/user-attachments/assets/79b99ef2-e616-440f-9790-3ae57447e42c" />
    </td>
  </tr>
</table>

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!  
Feel free to check [issues page](https://github.com/lcaxgg/ToastKit/issues).

---
