import Foundation

public struct ANSIParser: Sequence {
  private let string: String
  
  public init(string: String) {
    self.string = string
  }
  
  public func makeIterator() -> _ANSIParserIterator {
    return _ANSIParserIterator(string)
  }
  
  public struct _ANSIParserIterator: IteratorProtocol {
    let scanner: Scanner
    var state: Attributes
    
    init(_ string: String) {
      self.scanner = Scanner(string: string)
      self.scanner.charactersToBeSkipped = nil
      self.state = Attributes.pure
    }
    
    public mutating func next() -> (String, Attributes)? {
      guard !scanner.isAtEnd else {
        return nil
      }
      
      if let text = scanText() {
        return (text, state)
      } else {
        applyASCIICodes()
        return next()
      }
    }
    
    private func scanText() -> String? {
      var captured: NSString? = nil
      if scanner.scanUpTo("\\u001B[", into: &captured), let captured = captured {
        return captured as String
      } else {
        return nil
      }
    }
    
    private mutating func applyASCIICodes() {
      while scanner.scanString("\\u001B[", into: nil) {
        var code: Int = 0
        while scanner.scanInt(&code) {
          state = state.apply(code: code)
          scanner.scanString(";", into: nil)
        }
        scanner.scanString("m", into: nil)
      }
    }
  }
}

