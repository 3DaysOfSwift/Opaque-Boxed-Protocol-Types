//: ![3DaysOfSwift.com Logo](3DaysOfSwift-Header.png) © 2026 [3DaysOfSwift.com](https://www.3DaysOfSwift.com)
//:
//: Version 1.0 | Swift 6.2.3+ | Xcode 26.2+
//:
//: -------------------
//:
//: # Opaque & Boxed Protocol Types
//:
//: ## Opaque Return Types
//:
//: ### `some` hides a concrete type without erasing it
//:
//: An opaque return type hides the concrete type from the caller.
//:
//: The important part is what it does **not** do: it does not erase the concrete type from the compiler.
//:
//: The function still returns one specific underlying type.

import Foundation

protocol Badge {
    var title: String { get }
    func display() -> String
}

struct GoldBadge: Badge {
    let title: String

    func display() -> String {
        "🥇 \(title)"
    }
}

func makeFeaturedBadge() -> some Badge {
    GoldBadge(title: "Senior iOS Developer")
}

let badge = makeFeaturedBadge()
print(badge.display())
print(type(of: badge))

//: -------------------
//:
//: ## Example 2 — The Underlying Type Must Be Consistent
//:
//: This is the rule developers often miss.
//:
//: A function returning `some Badge` cannot return different concrete types from different branches.

struct SilverBadge: Badge {
    let title: String

    func display() -> String {
        "🥈 \(title)"
    }
}

func makeStableBadge(isFeatured: Bool) -> some Badge {
    // Both branches return GoldBadge.
    // The values differ, but the underlying concrete type is the same.
    if isFeatured {
        return GoldBadge(title: "Featured")
    } else {
        return GoldBadge(title: "Regular")
    }
}

print(makeStableBadge(isFeatured: true).display())
print(makeStableBadge(isFeatured: false).display())

// func makeUnstableBadge(isFeatured: Bool) -> some Badge {
//     if isFeatured {
//         return GoldBadge(title: "Featured")
//     } else {
//         return SilverBadge(title: "Regular")
//     }
// }
//
// This does not compile because the opaque return type must have one underlying type.

//: -------------------
//:
//: ## Example 3 — `some` Preserves Type Relationships
//:
//: Because the compiler still tracks the hidden type, two values returned by the same opaque function have a stable relationship.
//:
//: The caller cannot name the underlying type, but the compiler can still reason about it.

let first = makeFeaturedBadge()
let second = makeFeaturedBadge()

print(first.display())
print(second.display())

//: -------------------
//:
//: ## The Interview Point
//:
//: `some Badge` is not “any badge”.
//:
//: It means:
//:
//: > This API returns a specific concrete type that conforms to `Badge`, but the API chooses not to reveal that concrete type.
//:
//: This is why `some` is useful for API boundaries. It hides implementation detail without throwing away compile-time knowledge.
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
