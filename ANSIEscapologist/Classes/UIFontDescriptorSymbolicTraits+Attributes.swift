import UIKit

extension UIFontDescriptorSymbolicTraits {
  init(_ attributes: Attributes) {
    self.init(rawValue:
      (attributes.style.contains(.bold) ? UIFontDescriptorSymbolicTraits.traitBold.rawValue : 0) | (attributes.style.contains(.italic) ? UIFontDescriptorSymbolicTraits.traitItalic.rawValue : 0)
    )
  }
}
