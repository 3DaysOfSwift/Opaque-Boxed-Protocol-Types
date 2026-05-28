//: ![3DaysOfSwift.com Logo](3DaysOfSwift-Header.png) © 2026 [3DaysOfSwift.com](https://www.3DaysOfSwift.com)
//:
//: Version 1.0 | Swift 6.2.3+ | Xcode 26.2+
//:
//: -------------------
//:
//: # Opaque & Boxed Protocol Types
//:
//: ## Interview Drills
//:
//: ### reason about `some`, `any`, generics, and API design
//:
//: Use this page as a revision drill.
//:
//: Read each question, predict the answer, then run or modify the examples.

import Foundation

protocol Processor {
    associatedtype Input
    func process(_ input: Input) -> String
}

struct StringProcessor: Processor {
    func process(_ input: String) -> String {
        input.uppercased()
    }
}

struct IntProcessor: Processor {
    func process(_ input: Int) -> String {
        "Number: \(input)"
    }
}

//: -------------------
//:
//: ## Question 1
//:
//: Why can this function return `some Processor`?

func makeStringProcessor() -> some Processor {
    StringProcessor()
}

let stringProcessor = makeStringProcessor()
print(stringProcessor.process("interview"))

//: -------------------
//:
//: ## Question 2
//:
//: Why would this fail if the two branches returned different processor types?

func makeStableProcessor(debug: Bool) -> some Processor {
    if debug {
        return StringProcessor()
    } else {
        return StringProcessor()
    }
}

print(makeStableProcessor(debug: true).process("stable"))

//: -------------------
//:
//: ## Question 3
//:
//: When is `any Processor` useful despite losing direct access to a known `Input` type?

let processors: [any Processor] = [
    StringProcessor(),
    IntProcessor()
]

for processor in processors {
    print("Stored processor:", type(of: processor))
}

//: -------------------
//:
//: ## Question 4
//:
//: Why does a generic function preserve more type information than a boxed protocol value?

func runStringProcessor<P: Processor>(_ processor: P, input: P.Input) -> String {
    processor.process(input)
}

print(runStringProcessor(StringProcessor(), input: "generic"))
print(runStringProcessor(IntProcessor(), input: 42))

//: -------------------
//:
//: ## Question 5
//:
//: What does `some` in parameter position communicate here?

protocol Loggable {
    var logMessage: String { get }
}

struct LoginEvent: Loggable {
    let username: String
    var logMessage: String { "Login: \(username)" }
}

func log(_ value: some Loggable) {
    print(value.logMessage)
}

log(LoginEvent(username: "matthew"))

//: -------------------
//:
//: ## Question 6
//:
//: Why does `[any Loggable]` allow mixed concrete types?

struct PurchaseEvent: Loggable {
    let amount: Double
    var logMessage: String { "Purchase: \(amount)" }
}

let events: [any Loggable] = [
    LoginEvent(username: "matthew"),
    PurchaseEvent(amount: 19.99)
]

for event in events {
    print(event.logMessage, "—", type(of: event))
}

//: -------------------
//:
//: ## Question 7
//:
//: In a library API, when would returning `some Loggable` be better than returning `LoginEvent`?

func makePublicEvent() -> some Loggable {
    LoginEvent(username: "hidden implementation")
}

print(makePublicEvent().logMessage)

//: -------------------
//:
//: ## Question 8
//:
//: In a runtime factory, when would returning `any Loggable` be the honest design?

func makeEvent(kind: String) -> any Loggable {
    if kind == "purchase" {
        return PurchaseEvent(amount: 99.0)
    } else {
        return LoginEvent(username: "guest")
    }
}

print(makeEvent(kind: "purchase").logMessage)
print(makeEvent(kind: "login").logMessage)

//: -------------------
//:
//: ## Final Interview Prompt
//:
//: Explain the difference between these three declarations without using the words “basically the same”.
//:
//: ```swift
//: func makeValue() -> ConcreteType
//: func makeValue() -> some Protocol
//: func makeValue() -> any Protocol
//: ```
//:
//: A strong answer should discuss who chooses the type, whether the concrete type is stable, how much type information the compiler keeps, and whether runtime heterogeneity is part of the design.
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
