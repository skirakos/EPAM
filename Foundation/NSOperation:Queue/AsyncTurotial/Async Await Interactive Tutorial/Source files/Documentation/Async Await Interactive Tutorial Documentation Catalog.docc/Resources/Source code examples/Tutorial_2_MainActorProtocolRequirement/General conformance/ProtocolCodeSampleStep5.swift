import Foundation

@MainActor
protocol GeneralMainActorProtocol {
    func someMethodA()
    func someMethodB()
}

class GeneralConformanceViaExtension: @unchecked Sendable {
    func notProtocol() {}
}

extension GeneralConformanceViaExtension: GeneralMainActorProtocol {
    func someMethodA() {}
    func someMethodB() {}
}
