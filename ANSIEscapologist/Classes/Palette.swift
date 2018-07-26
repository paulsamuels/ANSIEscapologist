import UIKit

public enum Palette {
  case `default`
  case custom((Attributes.Color) -> UIColor)
  
  func transform(color: Attributes.Color) -> UIColor {
    switch self {
    case .default:              return defaultTrasformation(color)
    case .custom(let function): return function(color)
    }
  }
  
  func defaultTrasformation(_ color: Attributes.Color) -> UIColor {
    switch color {
    case .black:   return .black
    case .blue:    return .blue
    case .cyan:    return .cyan
    case .green:   return .green
    case .magenta: return .magenta
    case .red:     return .red
    case .white:   return .white
    case .yellow:  return .yellow
    }
  }
}
