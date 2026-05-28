//: ![3DaysOfSwift.com Logo](3DaysOfSwift-Header.png) © 2026 [3DaysOfSwift.com](https://www.3DaysOfSwift.com)
//:
//: Version 1.0 | Swift 6.2.3+ | Xcode 26.2+
//:
//: -------------------
//:
//: # Opaque & Boxed Protocol Types
//:
//: ## Designing API Boundaries
//:
//: ### choose concrete, generic, opaque, or boxed intentionally
//:
//: The best API choice depends on the relationship you want to express.
//:
//: Do not choose `some` or `any` because it looks modern.
//:
//: Choose the type shape that communicates the strongest correct contract.

import Foundation

protocol CachePolicy {
    func shouldStore(responseCode: Int) -> Bool
}

struct SuccessfulOnlyPolicy: CachePolicy {
    func shouldStore(responseCode: Int) -> Bool {
        (200..<300).contains(responseCode)
    }
}

struct StoreEverythingPolicy: CachePolicy {
    func shouldStore(responseCode: Int) -> Bool {
        true
    }
}

//: -------------------
//:
//: ## Example 1 — Return A Concrete Type When There Is No Need To Hide It

func makeConcretePolicy() -> SuccessfulOnlyPolicy {
    SuccessfulOnlyPolicy()
}

let concretePolicy = makeConcretePolicy()
print(concretePolicy.shouldStore(responseCode: 204))

//: -------------------
//:
//: ## Example 2 — Return `some` When The Implementation Should Be Hidden But Stable

func makeDefaultPolicy() -> some CachePolicy {
    SuccessfulOnlyPolicy()
}

let defaultPolicy = makeDefaultPolicy()
print(defaultPolicy.shouldStore(responseCode: 404))

//: -------------------
//:
//: ## Example 3 — Return `any` When The Concrete Type May Vary At Runtime

func makeRuntimePolicy(cacheEverything: Bool) -> any CachePolicy {
    if cacheEverything {
        return StoreEverythingPolicy()
    } else {
        return SuccessfulOnlyPolicy()
    }
}

let strict = makeRuntimePolicy(cacheEverything: false)
let permissive = makeRuntimePolicy(cacheEverything: true)

print(strict.shouldStore(responseCode: 500))
print(permissive.shouldStore(responseCode: 500))

//: -------------------
//:
//: ## Example 4 — Use Generics When The Caller Supplies The Type

struct NetworkClient<Policy: CachePolicy> {
    let policy: Policy

    func handle(responseCode: Int) {
        if policy.shouldStore(responseCode: responseCode) {
            print("Store response")
        } else {
            print("Do not store response")
        }
    }
}

let client = NetworkClient(policy: SuccessfulOnlyPolicy())
client.handle(responseCode: 201)
client.handle(responseCode: 500)

//: -------------------
//:
//: ## The Interview Point
//:
//: A strong answer is not “`some` is faster” or “`any` is flexible”.
//:
//: A stronger answer is:
//:
//: > I use concrete types when exposing the type is part of the API, generics when the caller chooses the type, `some` when the implementation chooses one hidden stable type, and `any` when the value is intentionally type-erased and may vary at runtime.
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
