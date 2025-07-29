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

func funWithProtocols() {
    Task {
        let general = await GeneralConformance.init()
        await general.someMethodA()
        await general.notProtocol()
    }
}
