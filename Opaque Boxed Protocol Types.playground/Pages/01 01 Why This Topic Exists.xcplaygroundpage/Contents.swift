//: ![3DaysOfSwift.com Logo](3DaysOfSwift-Header.png) © 2026 [3DaysOfSwift.com](https://www.3DaysOfSwift.com)
//:
//: Version 1.0 | Swift 6.2.3+ | Xcode 26.2+
//:
//: -------------------
//:
//: # Opaque & Boxed Protocol Types
//:
//: ## Why This Topic Exists
//:
//: ### Protocols describe capability; values still have concrete types
//:
//: `some` and `any` are not decoration.
//:
//: They answer two different API design questions:
//:
//: - `some Protocol` means: “I will hide the concrete type, but it is still one specific type.”
//: - `any Protocol` means: “This value is a box that can hold any conforming type.”
//:
//: Start with the simplest model: a protocol describes what a value can do.

import Foundation

protocol Renderable {
    func render() -> String
}

struct TextLabel: Renderable {
    let text: String

    func render() -> String {
        "TextLabel: \(text)"
    }
}

struct Icon: Renderable {
    let name: String

    func render() -> String {
        "Icon: \(name)"
    }
}

let title = TextLabel(text: "Checkout")
let symbol = Icon(name: "cart")

print(title.render())
print(symbol.render())

//: -------------------
//:
//: ## Example 2 — A Concrete Type Gives The Compiler Full Information
//:
//: `title` is not merely “something renderable”. It is a `TextLabel`.
//:
//: The compiler knows its stored properties, layout, methods, and exact type.

print(type(of: title))
print(title.text)

//: -------------------
//:
//: ## Example 3 — A Protocol-Typed Variable Hides The Concrete Interface
//:
//: Once a value is stored as `any Renderable`, the code is limited to the protocol interface.
//:
//: The underlying value is still a `TextLabel`, but the variable exposes only `render()`.

let item: any Renderable = TextLabel(text: "Profile")

print(item.render())
print(type(of: item))

// item.text
// The line above does not compile.
// The box promises Renderable behaviour, not TextLabel-specific properties.

//: -------------------
//:
//: ## The Interview Point
//:
//: A protocol is not automatically “the type of the value”.
//:
//: Swift makes you say whether you want:
//:
//: - a concrete generic relationship,
//: - an opaque value with a hidden but fixed concrete type,
//: - or an existential box that can hold different conforming types.
//:
//: Most confusion around `some` and `any` comes from treating all three as the same abstraction.
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
