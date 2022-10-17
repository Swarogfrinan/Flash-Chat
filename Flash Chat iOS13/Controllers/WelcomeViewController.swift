import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var letterIndex = 0.0
        
        let titleText = K.appName
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * letterIndex, repeats: false) {
                (timer) in
                self.titleLabel.text?.append(letter)
            }
            letterIndex += 1.0
        }
    }
    

}
