# Fuzzi
Locally searching in Swift made simple (and fuzzily).

## Wat?

Fuzzi allows you to search efficiently through a lot of data.
It uses BK-Tree's as well as a weigthed size based score with the Levenshtein distance of strings to find the correct results and sort them accordingly.

## Installing

Fuzzi is available on Cocoapods. (at least soon)
Simply add the following to your podfile:

```ruby
pod 'Fuzzi'
```

## Usage

Start by defining what you want to search. Let it implement the protocol `Searchable`. 
This will require it your data to be both Hashable, Equatable and Codable as well as provide the strings by which the data should be searched.

Like say:

```swift
struct Repo {
  let name: String
  let description: String
  let link: URL
}

extension Repo: Searchable {

  var hashValue: Int {
    return name.hashValue ^ description.hashValue ^ link.hashValue
  }
  
  static func == (lhs: Repo, rhs: Repo) -> Bool {
    return lhs.name == rhs.name && 
      lhs.description == rhs.description && 
      lhs.link == rhs.link
  }
  
  var searchableProperties: [KeyPath<Repo, String>] {
    return [
      \.name,
      \.description,
    ]
  }

}
```

Then whenever you have a collection of these objects simply use `.tree()` to create a searchTree.

```swift
let tree = repos.tree()

tree.search(for: "Fzzi") // Should return the "Fuzzi" repo
```

## Contributing

PRs are welcome!
