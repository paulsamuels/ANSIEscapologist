import Foundation

public struct Attributes {
  public let foreground: Color
  public let background: Color
  public let style: Style
  public let isInverted: Bool
  
  public enum Color { case black, red, green, yellow, blue, magenta, cyan, white }
  
  public struct Style: OptionSet {
    public let rawValue: Int
    
    public init(rawValue: Int) {
      self.rawValue = rawValue
    }
    
    static let bold          = Style(rawValue: 1 << 0)
    static let italic        = Style(rawValue: 1 << 1)
    static let underline     = Style(rawValue: 1 << 2)
    static let strikethrough = Style(rawValue: 1 << 3)
  }
}

extension Attributes {
  func apply(code: Int) -> Attributes {
    switch code {
    case 30: return set(foreground: .black)
    case 31: return set(foreground: .red)
    case 32: return set(foreground: .green)
    case 33: return set(foreground: .yellow)
    case 34: return set(foreground: .blue)
    case 35: return set(foreground: .magenta)
    case 36: return set(foreground: .cyan)
    case 37: return set(foreground: .white)
    case 39: return set(foreground: Attributes.pure.foreground)
      
    case 40: return set(background: .black)
    case 41: return set(background: .red)
    case 42: return set(background: .green)
    case 43: return set(background: .yellow)
    case 44: return set(background: .blue)
    case 45: return set(background: .magenta)
    case 46: return set(background: .cyan)
    case 47: return set(background: .white)
    case 49: return set(foreground: Attributes.pure.background)
      
    case 0:  return Attributes.pure
    case 7:  return set(isInverted: true)
    case 27: return set(isInverted: false)
      
    case 1:  return add(style: .bold)
    case 3:  return add(style: .italic)
    case 4:  return add(style: .underline)
    case 9:  return add(style: .strikethrough)
    case 22: return remove(style: .bold)
    case 23: return remove(style: .italic)
    case 24: return remove(style: .underline)
    case 29: return remove(style: .strikethrough)
      
    default:
      fatalError("Unknown code \(code)")
    }
    return self
  }
  
  static var pure: Attributes {
    return .init(foreground: .black, background: .white, style: [], isInverted: false)
  }
  
  func set(foreground: Color) -> Attributes {
    return .init(foreground: foreground, background: background, style: style, isInverted: isInverted)
  }
  
  func set(background: Color) -> Attributes {
    return .init(foreground: foreground, background: background, style: style, isInverted: isInverted)
  }
  
  func set(isInverted: Bool) -> Attributes {
    return .init(foreground: foreground, background: background, style: style, isInverted: isInverted)
  }
  
  func add(style: Style) -> Attributes {
    return .init(foreground: foreground, background: background, style: self.style.union(style), isInverted: isInverted)
  }
  
  func remove(style: Style) -> Attributes {
    return .init(foreground: foreground, background: background, style: self.style.subtracting(style), isInverted: isInverted)
  }
}
