//: ![3DaysOfSwift.com Logo](3DaysOfSwift-Header.png) © 2026 [3DaysOfSwift.com](https://www.3DaysOfSwift.com)
//:
//: Version 1.0 | Swift 6.2.3+ | Xcode 26.2+
//:
//: -------------------
//:
//: # Opaque & Boxed Protocol Types
//:
//: ## Boxed Protocol Types
//:
//: ### `any` stores a value whose concrete type may vary
//:
//: A boxed protocol type is also called an existential value.
//:
//: It is a box that can hold any concrete value that conforms to the protocol.
//:
//: This flexibility is useful, but it has different trade-offs from `some`.

import Foundation

protocol TimelineItem {
    var id: String { get }
    func summary() -> String
}

struct MessageItem: TimelineItem {
    let id: String
    let sender: String

    func summary() -> String {
        "Message from \(sender)"
    }
}

struct PhotoItem: TimelineItem {
    let id: String
    let filename: String

    func summary() -> String {
        "Photo: \(filename)"
    }
}

let oneItem: any TimelineItem = MessageItem(id: "m1", sender: "Amelia")
print(oneItem.summary())
print(type(of: oneItem))

//: -------------------
//:
//: ## Example 2 — Heterogeneous Collections Need `any`
//:
//: Arrays normally contain one element type.
//:
//: `[any TimelineItem]` means each element is a protocol box. Each box can hold a different concrete conforming type.

let feed: [any TimelineItem] = [
    MessageItem(id: "m1", sender: "Amelia"),
    PhotoItem(id: "p1", filename: "beach.png"),
    MessageItem(id: "m2", sender: "Luca")
]

for item in feed {
    print(item.id, "—", item.summary(), "— concrete type:", type(of: item))
}

//: -------------------
//:
//: ## Example 3 — The Box Restricts You To The Protocol Interface
//:
//: The compiler cannot assume every item is a `MessageItem`, because some are photos.
//:
//: Use casting only when the runtime type actually matters.

for item in feed {
    if let message = item as? MessageItem {
        print("Message-specific sender:", message.sender)
    } else {
        print("Not a message:", item.summary())
    }
}

//: -------------------
//:
//: ## The Interview Point
//:
//: `any TimelineItem` is the right tool when the value may be one of many conforming types.
//:
//: The cost is that code using the value works through the protocol interface and may require dynamic dispatch, storage indirection, or runtime casting when concrete behaviour is needed.
//:
//: That does not make `any` bad. It makes it a deliberate trade-off.
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
