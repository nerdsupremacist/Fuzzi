
import Foundation
import XCTest
@testable import Fuzzi

struct User: Searchable, Hashable {
    let firstname: String
    let lastname: String

    var fullname: String {
        return "\(firstname) \(lastname)"
    }

    var body: some Searchable {
        return fullname.searchWords().enablePrefixes(minimumPrefixSize: 3)
    }
}

struct Post: Searchable, Hashable {
    let author: User
    let text: String

    var body: some Searchable {
        CompoundSearchable {
            author

            text.searchWords()
        }
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
        let max = tree.search(query: "Max")  as [Post]
        let turtle = tree.search(query: "Turtlo")  as [Post]

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
        let componentsInTest = components(for: test)

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
        let componentsInTest = components(for: test)

        XCTAssertEqual(expectedComponents, componentsInTest)
    }

}
