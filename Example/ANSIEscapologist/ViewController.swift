import UIKit
import ANSIEscapologist

class ViewController: UIViewController {
  
  @IBOutlet weak var label: UILabel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let sample = """
      Terminal output looks better when you add \\u001B[31mcolour\\u001B[0m to \\u001B[31mt\\u001B[32mh\\u001B[33mi\\u001B[34mn\\u001B[35mg\\u001B[36ms\\u001B[0m. Sometimes more \\u001B[1memphasis\\u001B[22m is required, which might require additional styling like a cheeky \\u001B[4munderline\\u001B[0m or some \\u001B[3mitalics\\u001B[0m.
      """
    
    let example = NSMutableAttributedString()
    example.append(NSAttributedString(string: sample))
    example.append(NSAttributedString(string: "\n\nWhen trying to show the above text within a native app this won't look so pretty :(\n\nBelow is the same text that has been processed with ANSIEscapologist...\n\n"))
    example.append(ANSIEscapologist.attributedString(string: sample))
    
    label?.attributedText = example
  }
  
}
