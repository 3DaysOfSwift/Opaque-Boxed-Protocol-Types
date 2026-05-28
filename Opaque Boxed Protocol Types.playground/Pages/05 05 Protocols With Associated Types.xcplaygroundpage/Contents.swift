//: ![3DaysOfSwift.com Logo](3DaysOfSwift-Header.png) © 2026 [3DaysOfSwift.com](https://www.3DaysOfSwift.com)
//:
//: Version 1.0 | Swift 6.2.3+ | Xcode 26.2+
//:
//: -------------------
//:
//: # Opaque & Boxed Protocol Types
//:
//: ## Protocols With Associated Types
//:
//: ### associated types explain many `some` and `any` decisions
//:
//: Protocols with associated types are where the difference between `some` and `any` becomes more obvious.
//:
//: The protocol describes a family of types, but each conforming type chooses its own associated type.

import Foundation

protocol DataSource {
    associatedtype Element

    var items: [Element] { get }
}

struct UserSource: DataSource {
    let items: [String]
}

struct ScoreSource: DataSource {
    let items: [Int]
}

func makeUserSource() -> some DataSource {
    UserSource(items: ["Ava", "Ben", "Cleo"])
}

let users = makeUserSource()
print(users.items)
print(type(of: users.items))

//: -------------------
//:
//: ## Example 2 — `some` Preserves The Associated Type
//:
//: The caller does not know the concrete source type, but Swift still knows enough to expose the associated `Element` through the returned value.

for name in users.items {
    print(name.uppercased())
}

//: -------------------
//:
//: ## Example 3 — `any` Can Store Different Sources, But Loses Specific Element Knowledge
//:
//: An existential box can hold different sources.
//:
//: But once boxed, code cannot simply assume the element type without opening or casting the existential.

let mixedSources: [any DataSource] = [
    UserSource(items: ["Dina", "Eli"]),
    ScoreSource(items: [10, 20, 30])
]

for source in mixedSources {
    print("Source type:", type(of: source))
}

for source in mixedSources {
    if let userSource = source as? UserSource {
        print("Users:", userSource.items.joined(separator: ", "))
    } else if let scoreSource = source as? ScoreSource {
        print("Scores:", scoreSource.items.reduce(0, +))
    }
}

//: -------------------
//:
//: ## The Interview Point
//:
//: `some DataSource` keeps one hidden concrete type, so associated type information remains useful.
//:
//: `any DataSource` creates a box that can hold different conforming sources, so the code using the box cannot assume one stable associated type.
//:
//: This is a major reason `some` often feels more powerful than `any` when protocols contain `Self` or associated type requirements.
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
