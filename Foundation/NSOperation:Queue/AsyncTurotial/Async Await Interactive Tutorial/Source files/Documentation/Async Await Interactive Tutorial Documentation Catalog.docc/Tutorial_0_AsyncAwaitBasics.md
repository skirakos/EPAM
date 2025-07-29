# AsyncAwaitBasics

This article will guide you through the very basics of the async/await.

## Overview

Source:
* [SwiftLee](https://www.avanderlee.com)
* [Hacking with Swift](https://www.hackingwithswift.com)
* [Point-free](https://www.pointfree.co)


We highly encourage you to check it.

## What is async?

Async await is a part of the new structured concurrency changes that arrived in 
2021 as a part of Swift 5.5 update. Before it we used async methods with closure
completion callbacks. They were common to return from an asynchronous task 
often combined with a `Result` type parameter.
```swift
func fetchImages(completion: (Result<[UIImage], Error>) -> Void) {
    // .. perform data request
}
```

Defining method this way has few downsides that are solved by using async
instead:
* You must call completion closure in each possible method exit.
* Closures are harder to read since it is not easy to reason about the
execution order.
* Retain cycles need to be avoided using weak references.
* etc.

Async stands for 'asynchronous' and can be seen as a method attribute, making
it clear that a method performs asynchronous work.
```swift
func fetchImages() async throws -> [UIImage] {
    // .. perform data request
}
```

## What is await?

Await is a keyword to be used for calling async methods.

```swift
do {
    let images = try await fetchImages()
    print("Fetched \(images.count) images.")
} catch {
    print("Fetching images failed with error \(error)")
}
```

Above code example is performing an asynchronous task. Using the await keyword,
we tell the program to await a result from the `fetchImages` method and only
continue after a result is arrived.

## What is structured concurrency?

Structured concurrency with async-await method calls makes it easier to reason
about the execution order. Methods are linearly executed without going back and
forth like it happened with closures. Let's check it on an example. Let's first
implement `fetchImages` call with completion closure.
```swift
// 1. Call the method
fetchImages { result in
    // 3. The asynchronous method returns
    switch result {
    case .success(let images):
        print("Fetched \(images.count) images.")
    case .failure(let error):
        print("Fetching images failed with error \(error)")
    }
}
// 2. The calling method exits
```
This is an unstructured execution order which can be hard to follow. The calling
method returns before the images are fetched. The result is received and we go
back into our flow within the completion. It can become even more frustrating
with additional closure callbacks added

```swift
// 1. Call the method
fetchImages { result in
    // 3. The asynchronous method returns
    switch result {
    case .success(let images):
        print("Fetched \(images.count) images.")
        // 4. Call the resize method
        resizeImages(images) { result in
            // 6. Resize method returns
            switch result {
            case .success(let images):
                print("Decoded \(images.count) images.")
            case .failure(let error):
                print("Decoding images failed with error \(error)")
            }
        }
        // 5. Fetch images method returns
    case .failure(let error):
        print("Fetching images failed with error \(error)")
    }
}
// 2. The calling method exits
```

This time let's implement the same method call using structured concurrency.

```swift
do {
    // 1. Call the method
    let images = try await fetchImages()
    // 2. Fetch images method returns

    // 3. Call the resize method
    let resizedImages = try await resizeImages(images)
    // 4. Resize method returns

    print("Fetched \(images.count) images.")
} catch {
    print("Fetching images failed with error \(error)")
}
// 5. the calling method exits
```
The execution order is linear and easy to follow and reason.

## Async methods call in a function that does not support concurrency

While using async-await for the first time, you might run into an error
like this: "async call in a function that does not support concurrency".
The error is produced for the following code:

```swift
func fetchData() {
    do {
        try await fetchImages() // .. compiler check fails here
    } catch {
        // .. handle error
    }
}
```

The error arrives as we try to call an asynchronous method from a synchronous
calling environment that does not support concurrency. We should use `Task`
method to resolve it.

```swift
final class ContentViewModel: ObservableObject {
    @Published var images: [UIImage] = []
    func fetchData() {
        Task {
            do {
                self.images = try await fetchImages()
            } catch {
                // .. handle error 
            }
        }
    }
}
```
This way through Task we create an environment in which we can call
asynchronous methods.

## Async-await API value capturing

While using structured concurrency API we are not forced to use `self`
everywhere as it was with closures.
That was done on purpose. The idea behind it is to use `self` only when
the retain cycle might come in place.
However, there are some edge cases to keep in mind. Let's check it on an example.

```swift
final class Worker {
    func longRunningOperation() async { .. }

    func start() {
        Task {
            await longRunningOperation()
        }

    }
}
```
There is a Worker class that has an asynchronous task to complete, but the task needs to be launched synchronously.
Compiler does not enforce us to use `self` on attempt to reference `longRunningOperation()`. Mainly,
that will work in most of the cases since the task is likely to be launched and
terminated in some time.
Memory leaks are not expected here. However, in case you run into the problem
you should use a traditional
approach to resolve it

```swift
final class Worker {
    func longRunningOperation() async { .. }

    func start() { 
        Task {[weak self] in                     // weakify self
            await self?.longRunningOperation()    // add `self?` to a call of `longRunningOperation`
        }

    }
}
```

The trick will work but you need to keep in mind, that everything to the right
of the `await` statement is
strongly retained even though the task may be suspended for a while.
The issue becomes a real problem when
async sequence comes in place. Mainly, async sequences are infinitely long
and we shall have to use
`weak self` to break the retain cycle.

## Adopting async-await in an existing project

In order to illustrate existing refactoring approaches let's consider
the following code as refactoring input.

```swift
struct ImageFetcher {
    func fetchImages(completion: @escaping (Result<[UIImage], Error>) -> Void) {
        // .. perform data request
    }
}
```
Xcode suggests several options for automatic conversion of the implementation
into the one supporting async functionality.

![Xcode menu screenshot presenting async refactoring options for automatic code conversion.](AsyncAwaitBasicsRefactoring.png)


### Convert Function to Async

The first refactor option convers the fetch images method into an async varian
without keeping the non-async alternative. This option will be useful if you do
not want to maintain your old implementation. The resulting code looks
as follows:
```swift
    struct ImageFetcher {
        func fetchImages() async throws -> [UIImage] {
            // .. perform data request
        }
    }
```

### Add Async Alternative
This option makes sure to keep old implementation in place. Additionally
it adds an availability attribute:

```swift
struct ImageFetcher {
    @available(*, renamed: "fetchImages()")
    func fetchImages(completion: @escaping (Result<[UIImage], Error>) -> Void) {
        Task {
            do {
                let result = try await fetchImages()
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
    }


    func fetchImages() async throws -> [UIImage] {
        // .. perform data request
    }
}
```
This approach is useful to know where you need to update your code towards
the new concurrency option. The default implementation does not come with any
warning and you need to do an extra change to spawn it.
```swift
@available(*, deprecated, renamed: "fetchImages()")
```
After you build the project the implementation which make use of the old method
will get a warning as follows:

![Swift implementation screenshot presenting a warning for the deprecated method call.](AsyncAwaitBasicsRefactoringAsyncAlternative.png)

### Add Async Wrapper

Swift 5.5 introduces new methods `withCheckedThrowingContinuation` and
`withCheckedContinuation`. They are used to convert closure-based methods 
without much effort. As it is clear from the naming the first one is used 
o convert throwing methods while the second one is used for converting 
non-throwing ones. These methods suspend the current task until the given 
closure is called to trigger the continuation of the async-await method.

### Solving the "Reference to captured parameter 'self' in concurrently-executed code" error

The error appears when you are trying to reference an immutable instance 
of `self`. In other words, you are trying to reference either a property or 
an instance that is immutable.

![Swift implementation screenshot presenting a compiler check error for referencing an immutable instance of self.](AsyncAwaitBasicsRefactoringReferenceCapturedParameterSelfError.png)

To fix it either make a property mutable or change a struct into reference type.

## Sendable and @Sendable closures

The Sendable protocol and closure indicate whether the public API of the passed 
values passed thread-safe to
the compiler. A public API is safe to use across concurrency domains when:
* there are no public mutators
* an internal locking is in place
* mutators implement copy-on write behaviour like with value types

Many types of the standard library already support the Sendable protocol.

```swift
extension Int: Sendable {}
```

Once a value struct has a single property of type int, the Sendable protocol 
support will implicitly comes for free.

```swift
// Implicitly conforms to Sendable
struct Article {
    var views: Int
}
```

However, that does not work for classes since they are reference types and are 
mutable from other concurrent domains.

```swift
// Does not implicitly conform to Sendable
class Article {
    var views: Int
}
```

Compiler does not add implicit conformance to generic types if the generic type
does not have explicit Sendable protocol conformance.
```swift
// No implicit conformance to Sendable because Value does not conform to Sendable
struct Container<Value> {
    var child: Value
}
```

This issue can be resolved by adding protocol requirement to our generic value.

```swift
// Container implicitly conforms to Sendable as all its public properties do so
too.
struct Container<Value: Sendable> {
    var child: Value
}
```

The same is true in terms of enums with associated values.

```swift
// This will not work
enum State: Sendable {
    case loggedOut
    case loggedIn(name: NSAttributedString)
}

// We should follow this way to fix it
enum State: Sendable {
    case loggedOut
    case loggedIn(name: String)
}
```

### Throwing errors from thread-safe instances
The same rules apply to errors that want to conform to Sendable protocol.
```swift
struct ArticleSavingError: Error {
    var author: NonFinalAuthor
}

extension ArticleSavingError: Sendable { }
```

### How to use the Sendable protocol
The issues are expected to appear starting from the point where compiler can not
add implicit conformance on his own. In these cases we shall have to do it 
ourselves.
Common examples of types that are not implicitly sendable but can be marked 
as such are immutable classes and classes with internal locking mechanisms.

```swift
/// User is immutable and therefore thread-safe, so can conform to Sendable
final class User: Sendable {
    let name: String

    init(name: String) { self.name = name }
}
```

We need to mark mutable classes with the `@unchecked` attribute to indicate our 
class is thread-safe due to internal locking mechanism.

```swift
extension DispatchQueue {
    static let userMutatingLock = DispatchQueue(label: "person.lock.queue")
}

final class MutableUser: @unchecked Sendable {
    private var name: String = ""

    func updateName(_ name: String) {
        DispatchQueue.userMutatingLock.sync {
            self.name = name
        }
    }
}
```

### The restrictions of conforming to Sendable in the same source file
Sendable protocol conformance must happen within the same source file to ensure
that the compiler checks all visible members for thread safety.

For example, you could define the following type within a module like Swift
package.

```swift
public struct Article {
    internal var title: String
}
```
The article is public, while the title is internal and not visible outside 
the module. In this case the compiler can not apply Sendable conformance
outside of the source file.

The same issue comes up when trying to conform an immutable non-final class 
to Sendable.

```swift
// This will not work
class User: Sendable {
    let name: String

    init(name: String) { self.name = name }
}
```

We can use @unchecked attribute to get rid of the issue.

```swift
// This time it will work
class User: @unchecked Sendable {
    let name: String

    init(name: String) { self.name = name }
}
```

However, this does not require us to ensure thread-safety whenever we inherit 
from User.That is our
additional responsibility. Because of it, this approach is undesirable.

### How to use @Sendable
Functions can be passed across concurrency domains and will require sendable
conformance too. However,
functions can not conform to protocols. For this purposes Swift introduced 
the @Sendable attribute. Using it,
we will tell the compiler that he does not need extra synchronization as all 
captured values in the closure
are thread-safe. Here is an example of using closure from within Actor 
isolation.

```swift
actor ArticlesList {
    func filteredArticles(_ isIncluded: @Sendable (Article) -> Bool) async -> [Article] {
        // ...
    }
}
```

### Actor && Task Groups 

Actors are new in Swift 5.5. They aim to solve data races, but it's important to 
understand that it's likely
to still run into data races. Actors in Swift protect their state from data 
races. Using them allows
the compiler to give the developer a helpful feedback while writting 
an application. In addition, the Swift
compiler can statically enforce the limitations that come with actors and 
prevent concurrent access
to mutable data.

Actors are like other Swift types as they can also have initializers, methods,
properties, and subscripts.
They can also be used together with protocols and generics. However, 
unlike structs, defined initializer is required.
Actors are reference types but they are different compared to classes:
* inheritance is not supported as well as convenience initializers
* no `final` or `override` support

Please read this [Actors Swift Proposal](https://github.com/apple/swift-evolution/blob/main/proposals/0306-actors.md),
it perfectly describes this concept with all the pitfalls. **Must read guide.**

Please read this [Structured Concurrency Proposal](https://github.com/apple/swift-evolution/blob/main/proposals/0304-structured-concurrency.md) it perfectly explains also what is Task Groups, Unstructured tasks, Detached tasks. **Must read guide.**

While working with actors one should always keep in mind that:
* the value type properties are accessed within actor context synchronously
* you can not write properties from outside an actor
* creating an instance of an actor has no extra performance cost compared 
to creating an instance of a class.
The only performance difference comes when trying to access the protected 
state of an actor, which might
trigger the suspension point.

### Useful links for self-study
To have more hands-on experience with `Async\Await Basics`, please, feel free 
to check out this tutorial
by [Codeco](https://www.kodeco.com/25013447-async-await-in-swiftui) (a former www.http://raywenderlich.com)

and make sure you do not miss WWDC sessions on the topic
* [Apple - Meet async/await in Swift](https://developer.apple.com/videos/play/wwdc2021/10132/)
* [Apple - Use async/await with URLSession](https://developer.apple.com/videos/play/wwdc2021/10095/)
* [Apple - Swift concurrency: Behind the scenes](https://developer.apple.com/videos/play/wwdc2021/10254/)
* [Apple - Eliminate data races using Swift Concurrency](https://developer.apple.com/videos/play/wwdc2022/110351/)
* [Apple - Meet AsyncSequence](https://developer.apple.com/videos/play/wwdc2021/10058/)
