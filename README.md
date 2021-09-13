# Fuzzi
Locally searching in Swift made simple (and fuzzily). Using a SwiftUI like DSL.

## Wat?

Fuzzi allows you to search efficiently through a lot of data.
It uses BK-Tree's as well as a weigthed size based score with the Levenshtein distance of strings to find the correct results and sort them accordingly.

## Installation
### Swift Package Manager

You can install Fuzzi via [Swift Package Manager](https://swift.org/package-manager/) by adding the following line to your `Package.swift`:

```swift
import PackageDescription

let package = Package(
    [...]
    dependencies: [
        .package(url: "https://github.com/nerdsupremacist/Fuzzi.git", from: "1.0.0")
    ]
)
```

## Usage

Start by defining what you want to search. 

Like for example a GitHub Repo:

```swift
struct Repo {
  let name: String
  let description: String
  let link: URL
}
```

Then you can extend your struct by implementing `Searchable`. 
With `Searchable` you now tell our library, what to search for. In our current implementation we want to search for the name, description and link.

```swift
extension Repo: Searchable {

    var body: some Searchable {
        Text(name)
            .enablePrefixes()
            .weighted(scale: 5)

        Words(description)

        Text(link.absoluteString)
            .enableInfixes()
            .weighted(scale: 2)
    }

}
```
As you can see, we can also perform all kinds of optimizations, such as enabling search with prefixes, postfixes or infixes, and make certain strings in our struct weigh more than others.
Then whenever you have a collection of these objects simply use `.searchTree()` to create a Search Tree.

```swift
let tree = repos.searchTree()
tree.search(query: "Fzzi") // Should return the "Fuzzi" repo
```

Computing this tree might take a bit of time, however, after building this tree, searching through your results is a breeze!
We tested this with 10K items (single words). Building the tree took a bit longer than 5 seconds and searching took less than 1 second.

## Contributing

PRs are welcome!
