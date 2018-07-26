import XCTest
@testable import ANSIEscapologist

final class AttributesTests: XCTestCase {
    
    func testApply_constructsANewAttributesValueWithTheForegroundCodeApplied() {
        func foreground(for code: Int) -> Attributes.Color {
            return Attributes.pure.apply(code: code).foreground
        }
        
        XCTAssertEqual(foreground(for: 30), .black)
        XCTAssertEqual(foreground(for: 31), .red)
        XCTAssertEqual(foreground(for: 33), .yellow)
        XCTAssertEqual(foreground(for: 34), .blue)
        XCTAssertEqual(foreground(for: 35), .magenta)
        XCTAssertEqual(foreground(for: 36), .cyan)
        XCTAssertEqual(foreground(for: 37), .white)
        XCTAssertEqual(foreground(for: 39), .black)
    }
    
    func testApply_constructsANewAttributesValueWithTheBackgroundCodeApplied() {
        func background(for code: Int) -> Attributes.Color {
            return Attributes.pure.apply(code: code).background
        }
        
        XCTAssertEqual(background(for: 40), .black)
        XCTAssertEqual(background(for: 41), .red)
        XCTAssertEqual(background(for: 43), .yellow)
        XCTAssertEqual(background(for: 44), .blue)
        XCTAssertEqual(background(for: 45), .magenta)
        XCTAssertEqual(background(for: 46), .cyan)
        XCTAssertEqual(background(for: 47), .white)
        XCTAssertEqual(background(for: 49), .white)
    }
    
    func testANSICode0_returnsAttributesWithSensibleDefaults() {
        let sut = Attributes.pure.apply(code: 0)
        
        XCTAssertEqual(sut.background, .white)
        XCTAssertEqual(sut.foreground, .black)
        XCTAssertEqual(sut.style, [])
        XCTAssertFalse(sut.isInverted)
    }
    
    func testApply_constructsANewAttributesValueWithTheInvertedCodeApplied() {
        XCTAssertTrue(Attributes.pure.apply(code: 7).isInverted)
        XCTAssertFalse(Attributes.pure.apply(code: 7).apply(code: 27).isInverted)
    }
    
    func testApply_constructsANewAttributesValueWithTheStyleCodeApplied() {
        func style(for code: Int) -> Attributes.Style {
            return Attributes.pure.apply(code: code).style
        }
        
        XCTAssertEqual(style(for: 1), .bold)
        XCTAssertEqual(style(for: 3), .italic)
        XCTAssertEqual(style(for: 4), .underline)
        XCTAssertEqual(style(for: 9), .strikethrough)
        
        XCTAssertEqual(Attributes.pure.apply(code: 1).apply(code: 22).style, [])
        XCTAssertEqual(Attributes.pure.apply(code: 3).apply(code: 23).style, [])
        XCTAssertEqual(Attributes.pure.apply(code: 4).apply(code: 24).style, [])
        XCTAssertEqual(Attributes.pure.apply(code: 9).apply(code: 29).style, [])
    }
    
    func testPure_returnsAttributesWithSensibleDefaults() {
        let sut = Attributes.pure
        
        XCTAssertEqual(sut.background, .white)
        XCTAssertEqual(sut.foreground, .black)
        XCTAssertEqual(sut.style, [])
        XCTAssertFalse(sut.isInverted)
    }
    
    func testSetForeground_updatesTheForegroundWithTheNewValue() {
        let original = Attributes.pure
        let sut      = original.set(foreground: .green)
        
        XCTAssertEqual(sut.background, original.background)
        XCTAssertEqual(sut.foreground, .green)
        XCTAssertEqual(sut.style,      original.style)
        XCTAssertEqual(sut.isInverted, original.isInverted)
    }
    
    func testSetBackground_updatesTheBackgroundWithTheNewValue() {
        let original = Attributes.pure
        let sut      = original.set(background: .green)
        
        XCTAssertEqual(sut.background, .green)
        XCTAssertEqual(sut.foreground, original.foreground)
        XCTAssertEqual(sut.style,      original.style)
        XCTAssertEqual(sut.isInverted, original.isInverted)
    }
    
    func testSetIsInverted_updatesTheIsInvertedWithTheNewValue() {
        let original = Attributes.pure
        let sut      = original.set(isInverted: true)
        
        XCTAssertEqual(sut.background, original.background)
        XCTAssertEqual(sut.foreground, original.foreground)
        XCTAssertEqual(sut.style,      original.style)
        XCTAssertEqual(sut.isInverted, true)
    }
    
    func testAddStyle_appendsTheNewStyle() {
        let original = Attributes.pure
        let sut      = original.add(style: .strikethrough)
        
        XCTAssertEqual(sut.background, original.background)
        XCTAssertEqual(sut.foreground, original.foreground)
        XCTAssertEqual(sut.style,      .strikethrough)
        XCTAssertEqual(sut.isInverted, original.isInverted)
    }
    
    func testRemoveStyle_removesTheStyle() {
        let original = Attributes(foreground: .black, background: .white, style: .strikethrough, isInverted: false)
        let sut      = original.remove(style: .strikethrough)
        
        XCTAssertEqual(sut.background, original.background)
        XCTAssertEqual(sut.foreground, original.foreground)
        XCTAssertEqual(sut.style,      [])
        XCTAssertEqual(sut.isInverted, original.isInverted)
    }

}
