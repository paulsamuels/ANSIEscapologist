import UIKit

public enum ANSIEscapologist {
  public static let defaultFont = UIFont(name: "Courier New", size: UIFont.systemFontSize) ?? UIFont.systemFont(ofSize: UIFont.systemFontSize)
  
  public static func attributedString(string: String, font: UIFont = defaultFont, palette: Palette = .default) -> NSAttributedString {
    return ANSIParser(string: string).reduce(into: NSMutableAttributedString()) { result, component in
      let (stringPart, attributes) = component
      
      let displayFont = font.fontDescriptor.withSymbolicTraits(UIFontDescriptorSymbolicTraits(attributes)).flatMap({ UIFont(descriptor: $0, size: font.pointSize) }) ?? font
      
      let attributedStringAttributes: [NSAttributedStringKey : Any] = [
        .backgroundColor    : palette.transform(color: attributes.isInverted ? attributes.foreground : attributes.background),
        .foregroundColor    : palette.transform(color: attributes.isInverted ? attributes.background : attributes.foreground),
        .strikethroughStyle : attributes.style.contains(.strikethrough) ? NSUnderlineStyle.styleSingle.rawValue : NSUnderlineStyle.styleNone.rawValue,
        .underlineStyle     : attributes.style.contains(.underline)     ? NSUnderlineStyle.styleSingle.rawValue : NSUnderlineStyle.styleNone.rawValue,
        .font               : displayFont,
        ]
      
      result.append(NSAttributedString(string: stringPart, attributes: attributedStringAttributes))
    }
  }
}
