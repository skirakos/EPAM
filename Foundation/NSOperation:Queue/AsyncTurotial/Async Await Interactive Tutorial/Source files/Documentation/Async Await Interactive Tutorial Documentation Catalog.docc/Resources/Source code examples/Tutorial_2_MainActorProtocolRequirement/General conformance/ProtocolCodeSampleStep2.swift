import Foundation

@MainActor
protocol GeneralMainActorProtocol {
    func someMethodA()
    func someMethodB()
}

class GeneralConformance: GeneralMainActorProtocol, @unchecked Sendable {
    func someMethodA() {}
    func someMethodB() {}
    func notProtocol() {}
}
