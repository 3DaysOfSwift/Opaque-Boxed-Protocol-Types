//: ![3DaysOfSwift.com Logo](3DaysOfSwift-Header.png) © 2026 [3DaysOfSwift.com](https://www.3DaysOfSwift.com)
//:
//: Version 1.0 | Swift 6.2.3+ | Xcode 26.2+
//:
//: -------------------
//:
//: # Opaque & Boxed Protocol Types
//:
//: ## Some Parameters And Generics
//:
//: ### opaque parameters are a concise form of generic input
//:
//: `some` is not only used for return values.
//:
//: It can also appear in parameter positions.
//:
//: For input parameters, `some Protocol` usually means “this function is generic over one concrete conforming type”.

import Foundation

protocol IdentifiableItem {
    var id: String { get }
}

struct User: IdentifiableItem {
    let id: String
    let name: String
}

struct Order: IdentifiableItem {
    let id: String
    let total: Double
}

func printID(_ item: some IdentifiableItem) {
    print("ID:", item.id)
}

printID(User(id: "u1", name: "Nora"))
printID(Order(id: "o1", total: 49.99))

//: -------------------
//:
//: ## Example 2 — The Generic Form Makes The Same Idea Explicit
//:
//: This version exposes the generic parameter name.
//:
//: That becomes useful when the type must appear in more than one place.

func printIDGeneric<T: IdentifiableItem>(_ item: T) {
    print("Generic ID:", item.id)
}

printIDGeneric(User(id: "u2", name: "Omar"))
printIDGeneric(Order(id: "o2", total: 19.99))

//: -------------------
//:
//: ## Example 3 — Use A Named Generic When Values Must Match
//:
//: `some IdentifiableItem` is concise, but it does not let you express that two parameters must be the same concrete type.
//:
//: A named generic parameter does.

func compareSameType<T: IdentifiableItem>(_ first: T, _ second: T) {
    print("Same concrete generic type:", first.id, second.id)
}

compareSameType(
    User(id: "u3", name: "Mia"),
    User(id: "u4", name: "Kai")
)

// compareSameType(
//     User(id: "u5", name: "Iris"),
//     Order(id: "o5", total: 9.99)
// )
// This does not compile because T must be one concrete type for the call.

func compareAnyItems(_ first: any IdentifiableItem, _ second: any IdentifiableItem) {
    print("Any two identifiable values:", first.id, second.id)
}

compareAnyItems(
    User(id: "u5", name: "Iris"),
    Order(id: "o5", total: 9.99)
)

//: -------------------
//:
//: ## The Interview Point
//:
//: Use `some` in parameter position when the function does not need to name the generic type.
//:
//: Use a named generic when the same concrete type must be reused across parameters, return values, or constraints.
//:
//: Use `any` when the values are intentionally allowed to be different conforming types.
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
