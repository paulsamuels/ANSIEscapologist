import XCTest
@testable import ANSIEscapologist

class ANSIParserTests: XCTestCase {

    func testParserHandlesANSICodesAtTheBeginningOfTheLine() {
        guard let (_, attributes) = test("\\u001B[32m ").first else {
            return XCTFail("Expected attributes")
        }
        
        XCTAssertEqual(attributes.foreground, .green)
    }
    
    func testParserHandlesMultipleEscapeCodesInARow() {
        guard let (_, attributes) = test("\\u001B[35m\\u001B[41m ").first else {
            return XCTFail("Expected attributes")
        }
        
        XCTAssertEqual(attributes.foreground, .magenta)
        XCTAssertEqual(attributes.background, .red)
    }
    
    func testParserHandlesMultipleCodesSeparatedBySemiColon() {
        guard let (_, attributes) = test("\\u001B[36;43m ").first else {
            return XCTFail("Expected attributes")
        }
        
        XCTAssertEqual(attributes.foreground, .cyan)
        XCTAssertEqual(attributes.background, .yellow)
    }
    
    func testParserExtractsStrings() {
        let results = test("PlainString\\u001B[4mUnderlineString")
        
        guard results.count == 2 else {
            return XCTFail("Expected 2 sections")
        }
        
        XCTAssertEqual(results[0].0, "PlainString")
        XCTAssertEqual(results[0].1, Attributes(foreground: .black, background: .white, style: [], isInverted: false))
        XCTAssertEqual(results[1].0, "UnderlineString")
        XCTAssertEqual(results[1].1, Attributes(foreground: .black, background: .white, style: .underline, isInverted: false))
    }
    
    func test(_ input: String) -> [(String, Attributes)] {
        return Array(ANSIParser(string: input))
    }
}

extension Attributes: Equatable {
    public static func ==(lhs: Attributes, rhs: Attributes) -> Bool {
        return lhs.background == rhs.background && lhs.foreground == rhs.foreground && lhs.style == rhs.style && lhs.isInverted == rhs.isInverted
    }
}
