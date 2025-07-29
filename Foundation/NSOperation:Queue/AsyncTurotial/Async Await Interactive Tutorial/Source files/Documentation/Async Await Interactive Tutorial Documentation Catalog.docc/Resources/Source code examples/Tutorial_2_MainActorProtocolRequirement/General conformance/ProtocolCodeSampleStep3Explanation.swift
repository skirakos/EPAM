import Foundation

@MainActor
protocol GeneralMainActorProtocol {
    func someMethodA()
    func someMethodB()
}

class GeneralConformance: GeneralMainActorProtocol, @unchecked Sendable {
    func someMethodA() {}
    func someMethodB() {}
    /*
     This function is not a part of the protocol ..
     */
    func notProtocol() {}
}

func funWithProtocols() {
    Task {
        let general = await GeneralConformance.init()
        await general.someMethodA()
        /*
         .. nevertheless, we have to use await declaration prior calling it.
         It happens because of class general conformance to the protocol.
         In case you omit it the compiler will through an error.

         Note: `MainActor` requirment applied to the whole protocol requires
         the adopter to execute all of his functions within the `MainActor`
         context.
         */
        await general.notProtocol()
    }
}
