
import Foundation
import XCTest
@testable import Fuzzi

struct User: Searchable, Hashable, Codable {
    let firstname: String
    let lastname: String

    var fullname: String {
        return "\(firstname) \(lastname)"
    }

    var body: some Searchable {
        Words(fullname)
            .enablePrefixes(minimumPrefixSize: 3)
    }
}

struct Post: Searchable, Hashable, Codable {
    let author: User
    let text: String

    var body: some Searchable {
        author

        Words(text)
    }
}

class SearchableTest: XCTestCase {

    func testSearchTree() {
        let firstUser = User(firstname: "Mathias", lastname: "Quintero")
        let secondUser = User(firstname: "Max", lastname: "Mustermann")

        let posts = [
            Post(author: firstUser, text: "Helloo World! This is a long post"),
            Post(author: firstUser, text: "I like turtles"),
            Post(author: secondUser, text: "Hi there!"),
        ]

        let tree = posts.searchTree()
        let max = tree.search(query: "Max")
        let turtle = tree.search(query: "Turtlo")

        XCTAssertEqual(posts[2], max.first)
        XCTAssertEqual([posts[1]], turtle)
    }

    func testExample() {
        let test = Post(author: User(firstname: "Mathias", lastname: "Quintero"),
                        text: "Hello World!")

        let expectedComponents: Set<String> = [
            "Mathias",
            "Mathia",
            "Mathi",
            "Math",
            "Mat",
            "Quintero",
            "Quinter",
            "Quinte",
            "Quint",
            "Quin",
            "Qui",
            "Hello",
            "World",
        ]
        let componentsInTest = Set(components(for: test).keys)

        XCTAssertEqual(expectedComponents, componentsInTest)
    }

    func testInfixes() {
        let test = "Hello World!".searchWords().enableInfixes(minimumSize: 2)

        let expectedComponents: Set<String> = [
            "Hello",
            "World",
            "Hell",
            "ello",
            "Hel",
            "ell",
            "llo",
            "He",
            "el",
            "ll",
            "lo",
            "Worl",
            "orld",
            "Wor",
            "orl",
            "rld",
            "Wo",
            "or",
            "rl",
            "ld",
        ]
        let componentsInTest = Set(components(for: test).keys)

        XCTAssertEqual(expectedComponents, componentsInTest)
    }

    func testLongList() {
        let path = "/Users/mathiasquintero/Downloads/words_alpha.txt"

        guard FileManager.default.fileExists(atPath: path) else {
            print("File not found. Skipping test")
            return
        }

        let url = URL(fileURLWithPath: path)
        let data = try! Data(contentsOf: url)
        guard let string = String(data: data, encoding: .utf8) else { return }
        let words = string.components(separatedBy: .whitespacesAndNewlines).filter { !$0.isEmpty }
        let first = words.dropLast(words.count - 10_000)

        print("Building Tree with \(first.count) words")

        let (tree, treeTime) = measureResult {
            first.searchTree { word in
                if !word.isEmpty {
                    Text(word)
                }
            }
        }

        print("Took \(treeTime)s to build a tree")

        let (results, searchTime) = measureResult {
            tree.search(query: "aardvark")
        }
        print("Took \(searchTime) to search through huge list")
        print(results)
    }

}

func measureResult<T>(_ block: () throws -> T) rethrows -> (T, TimeInterval) {
    let start = CFAbsoluteTimeGetCurrent()
    let result = try block()
    let end = CFAbsoluteTimeGetCurrent()
    return (result, end - start)
}

struct Repo {
  let name: String
  let description: String
  let link: URL
}

extension Repo: Searchable {

    var body: some Searchable {
        Text(name)
            .enablePrefixes()
            .weighted(scale: 5)

        Words(description)
            .weighted(scale: 0.5)

        Text(link.absoluteString)
            .enableInfixes()
    }

}
