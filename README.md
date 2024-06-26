# Project - Clean Architecture and `The Composable Architecture` on iOS

<p style="text-align:center;">
  <a href="https://developer.apple.com"><img alt="Platform" src="https://img.shields.io/badge/platform-iOS,%20tvOS-blue"/></a>
  <img alt="OS" src="https://img.shields.io/badge/OS-16.0%2B-brightgreen.svg?style=flat"/>
</p>

## iOS Tech stack
| Development Aspect | Tech |
| ------------- |:-------------:|
| Modularity      | `Swift Package Manager`       |
| Multi Threading      |`swift async-await` | `Task` & `Combine`     |
| Design Pattern      | `MVVM`   |
| Depedency Injection      | `Dependencies` https://github.com/pointfreeco/swift-dependencies - `@Dependency`    |
| Networking      | `URLSession`   |
| Json Mapping | `Decodable` |
| View | `SwiftUI` 
| Tests | `XCTest` |

## What is Clean Architecture?

Clean architecture pattern emphasizes the sepration of concertns between different layers to create an application structure that is isolated, testable and easy to maintain.

![Clean Architecture drawio](https://github.com/tarunkhurana2015/cleanarchitecture-ios/assets/9640541/191e96d7-9ba0-4452-b435-2857fe9a6c8a)


## Getting Started
In this propject we will use the `Modular`, `Clean Architecture`, `MVVM` and `The Composable Architecture` patterns.

## Dependency rules

The source code dependencies must always `flow inward`. This means that elements within an inner circle cannot posses any knowledge about the entities within an outer circle.

By enforcing that dependencies flow only inward, the architecture becomes highly modular. Each circle encapsulates a distint area of functionality. This propmots ease of maintainence as changes within an inner circle have minimal impact on the outer circles and vice versa.

### Dependency Inversion
One of the important cases is the communication between the domain components and the data or presentation layer. For example, the `Use Case` may need access to a `Repository` to retrieve data, but it should not depend on the implementation of the Repository, only on it's interface. This is the `Dependency Inversion` princile in action, which ensures that high-level components in the domain layer are not directly dependent on low-level components in the data or presentation layer.

## Layers
The Clean Architecture divides a project into 3 layers:

![Cleanarch_layers drawio](https://github.com/taruncopper/cleanarchitecture/assets/167800713/b6888942-b3a5-4cda-a503-cd8819ae15c9)

1. **Domain Layer** - `(Business logic)` is the inner-most part of the onion (without dependencies to other layers, it is totally isolated). It contains `Entities(Business Models)`, `Use Cases`, and `Repository Interfaces`. This layer could be potentially reused within different projects. Such separation allows for not using the host app within the test target because no dependencies (also 3rd party) are needed — this makes the Domain Use Cases tests take just a few seconds. Note: Domain Layer should not include anything from other layers(e.g Presentation — UIKit or SwiftUI or Data Layer — Mapping Codable).
2. **Presentation Layer** - contains `UI (UIViewControllers or SwiftUI Views)`. Views are coordinated by `ViewModels (Presenters)` which execute one or many Use Cases. Presentation Layer depends only on the `Domain Layer`.
3. **Data Layer** - contains Repository Implementations and one or many Data Sources. Repositories are responsible for coordinating data from different Data Sources. Data Source can be Remote or Local (for example persistent database). Data Layer depends only on the Domain Layer. In this layer, we can also add mapping of Network JSON Data (e.g. Decodable conformance) to Domain Models.

## Dependency Graph

![cleanArch_dataDepedency drawio](https://github.com/taruncopper/cleanarchitecture/assets/167800713/b58d47dd-f875-497c-aa38-3afb0828aed3)

### Data Flow
1. `View`(UI) calls action from `Store` (Recucer).

2. `Reducer` executes `Use Case`.

3. `Use Case` combines data from `User` and `Repositories`.

4. Each `Repository` returns data from a `Remote Data` (Network), `Persistent DB` Storage Source or `In-memory` Data (Remote or Cached).

5. Information flows back to the `View`(UI) where we display the list of items.

### Dependency Direction
`Presentation Layer` -> `Domain Layer` <- `Data Repositories Layer`

`Presentation Layer (MVVM)` = Store(Reducers) + Views(UI)

`Domain Layer` = Entities + Use Cases + Repositories Interfaces

`Data Repositories Layer` = Repositories Implementations + API(Network) + Persistence DB

## Modular Architecture
`Modular Programming` is a software design technique that emphasizes separating the functionality of a program into independent, interchangeable modules, such that each contains everything necessary to execute only one aspect of the desired functionality.

Every module will have it's own `Clean Architecture : Presentation, Domain and Data`

It's important to mention the modules are local, which means that they are located in the same repo `(monorepo)` as teh main App, inside the folder with the name of the `Feature`. We only make them remote, in a separate repo, when we want to share them with another project. This makes sense until a new second project needs to use this module then it can be very easily moved to its own repo. 
As a general rule, we try to minimize the use of 3rd party framework in this Architecture too. If a module needs to depend on 3rd party framework, we try to isolate this use by using wrappers and limit the use of this dependency only to one module. We explain this on an example inside the section below: `Authentication`.

### How to create a package and depdencies?
The `Swift Package Manager (SPM)` make the addition of the local modules very simple. We will define the `Package.swift` for every `Feature` Package.
```swift
let package = Package(
    name: "Feature",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "<FeatureName>",
            targets: ["<FeatureName>"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-dependencies", exact: "1.2.2"),  // 3rd party package
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", exact: "1.10.0"), // 3rd partty package
        .package(name: "Core", path: "../Core") // local package
    ],
    .target(
            name: "User",
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies"), // 3rd party dependency
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"), // 3rd party dependency
                .product(name: "Networking", package: "Core"), // local dependency
                .product(name: "Authentication", package: "Core") // local dependency
            ])
    ]
)
```
### Advantages of Modular Architecture?
`Builds times` are faster. Changing one feature module will not affect other modules. And the app will compile faster by recompiling only the changed module. Compiling a big monolith app is much much slower than compiling isolating part(both clean and incremental builds). For example, our clean build time of all app is: 4 minutes vs Payments module example/demo app: 1 minute.

`Development time` is faster. The improvement is not only in compiling speed but also in accessing the screen that we are developing. For example, during module development from example project, you can easily open this screen as the initial screen in the app launch. You do not need to get through all the screens as it happens usually when we are developing in the main app.

`Isolation of Change.` When developing in modules there is clear responsibility of the area of code in the project, and when doing merge requests it is easy to see what module is affected.

`Tests running in seconds` because they still will run without host app, they will be in package of the module.

### Module Dependencies rules:
Modules can depend on each other(without `circular dependencies`) and on 3rd party frameworks. (e.g dependency A<->B is not allowed)

A ->B->C means that module A which imports B will have access also to C

### Applying Modular Architecture on `demo project`

[Demo App](https://github.com/taruncopper/cleanarchitecture.git) is a simple project to implement the User's `Sign Up` and `Sign In` modules uisng the JWT login. The server [authentication](https://github.com/taruncopper/authentication.git) is written in `Node.js` using `Express` and `Typescript`.

<img width="213" alt="image" src="https://github.com/taruncopper/cleanarchitecture/assets/167800713/d78fedf5-c9fb-4df1-a304-3b3073fbcaf8">

The Demo project has 2 packages - 
1. `Core` - This is the package that contains 2 libraries within in, `Authentication` and `Networking`. In future this will expand to have `Storage`, `ImageService`, etc as a part of it. The `Core` module is a common module that will be imported to the other `Feature` moddule for making the network request or storing data.
`Package.swift`
```swift
import PackageDescription

let package = Package(
    name: "Core",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Networking",
            targets: ["Networking"]),
        .library(
            name: "Authentication",
            targets: ["Authentication"])
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Networking"),
        .testTarget(
            name: "NetworkingTests",
            dependencies: [
                "Networking"
            ]
        ),
        .target(
            name: "Authentication",
            dependencies: [
                "Networking"
            ]
        ),
        .testTarget(
            name: "AuthenticationTests",
            dependencies: [
                "Authentication",
                "Networking"
            ]
        ),
    ]
)
```

2. `User` - This is a `Feature` module that follow the `The Clean Architecture` guidelines.
   <img width="314" alt="image" src="https://github.com/taruncopper/cleanarchitecture/assets/167800713/aae627dd-cdd3-482d-adc8-37e16b5bf573">

### The Clean Architecture Layers Dependency Injection is done using [swift-dependencies](https://github.com/pointfreeco/swift-dependencies)

### The Presentation Layer implemnets the [swift-composable-architecture](https://github.com/pointfreeco/swift-composable-architecture.git) pattern between the View and the Reducers. 
