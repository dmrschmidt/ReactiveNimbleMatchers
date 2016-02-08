import Foundation
import Nimble
import ReactiveCocoa

/// A Nimble matcher that succeeds when the actual value is nil.
public func sendNext(expected: String) -> MatcherFunc<SignalProducer<String, NSError>> {
    return MatcherFunc { actualExpression, failureMessage in
        failureMessage.postfixMessage = "send next"

        var actualValue: String?
        if let producer = try actualExpression.evaluate() {
            producer.startWithNext { next in actualValue = next }
        }

        return actualValue == expected
    }
}