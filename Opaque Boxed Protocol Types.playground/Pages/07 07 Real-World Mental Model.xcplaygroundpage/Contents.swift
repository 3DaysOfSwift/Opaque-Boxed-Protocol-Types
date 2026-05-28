//: ![3DaysOfSwift.com Logo](3DaysOfSwift-Header.png) © 2026 [3DaysOfSwift.com](https://www.3DaysOfSwift.com)
//:
//: Version 1.0 | Swift 6.2.3+ | Xcode 26.2+
//:
//: -------------------
//:
//: # Opaque & Boxed Protocol Types
//:
//: ## Real-World Mental Model
//:
//: ### SwiftUI-style APIs are easier to understand through `some`
//:
//: Many developers first see `some` in SwiftUI.
//:
//: This page uses a small fake view system so the concept stays pure Swift and runnable in a playground.

import Foundation

protocol MiniView {
    func draw(indentation: String) -> String
}

struct MiniText: MiniView {
    let value: String

    func draw(indentation: String = "") -> String {
        "\(indentation)Text(\(value))"
    }
}

struct MiniStack<Content: MiniView>: MiniView {
    let content: Content

    func draw(indentation: String = "") -> String {
        "\(indentation)Stack\n" + content.draw(indentation: indentation + "  ")
    }
}

func makeTitleView() -> some MiniView {
    MiniStack(content: MiniText(value: "Settings"))
}

let titleView = makeTitleView()
print(titleView.draw(indentation: ""))
print(type(of: titleView))

//: -------------------
//:
//: ## Example 2 — The Return Type Can Be Large, But The API Can Stay Small
//:
//: The concrete type here is `MiniStack<MiniStack<MiniText>>`.
//:
//: Exposing that in a public API would be noisy. `some MiniView` hides the concrete structure while preserving compile-time knowledge.

func makeNestedView() -> some MiniView {
    MiniStack(content: MiniStack(content: MiniText(value: "Advanced Settings")))
}

let nestedView = makeNestedView()
print(nestedView.draw(indentation: ""))
print(type(of: nestedView))

//: -------------------
//:
//: ## Example 3 — Boxed Views Allow Runtime Choice
//:
//: When the concrete type genuinely changes at runtime, `any MiniView` expresses that flexibility.

struct MiniIcon: MiniView {
    let name: String

    func draw(indentation: String = "") -> String {
        "\(indentation)Icon(\(name))"
    }
}

func makeRuntimeView(showIcon: Bool) -> any MiniView {
    if showIcon {
        return MiniIcon(name: "gear")
    } else {
        return MiniText(value: "Settings")
    }
}

let runtimeViews: [any MiniView] = [
    makeRuntimeView(showIcon: true),
    makeRuntimeView(showIcon: false)
]

for view in runtimeViews {
    print(view.draw(indentation: ""))
    print("Concrete:", type(of: view))
}

//: -------------------
//:
//: ## The Interview Point
//:
//: `some View` in SwiftUI does not mean “return any view”.
//:
//: It means the body has one compiler-known concrete type, even if that type is deeply nested and intentionally hidden from source code.
//:
//: `AnyView`-style type erasure is different. It is useful when you truly need runtime variation, but it removes static type information that Swift could otherwise use.
//:
//: -------------------
//:
//: ![3DaysOfSwift.com Logo](3DaysOfSwift-Header.png) © 2026 [3DaysOfSwift.com](https://www.3DaysOfSwift.com). All rights reserved.
//:
//: [Website](https://www.3DaysOfSwift.com) | [Subreddit Community](https://www.Reddit.com/r/3DaysOfSwift)
//:
//: Built for professional iOS developers.
//:
//: 👩🏿‍💻🧑🏻‍💻🙋🏿‍♀️🧑🏼‍💻👩🏼‍💼👩🏽‍💻🧑🏿‍💻💁🏼‍♀️👩🏼‍💻👨🏼‍💻👨🏽‍💻🙋🏽‍♂️👩🏻‍💻🧑🏾‍💻👩🏻‍💻👩🏾‍💻👨🏼‍💻🙋🏻‍♂️👨🏿‍💻🙋🏼‍♂️
//:
