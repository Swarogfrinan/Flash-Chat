import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    // MARK: - Actions
    
   
        @IBAction func registerPressed(_ sender: UIButton) {
            if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().createUser(withEmail: email, password: password) {
                authResult, error in
                if let strongError = error {
                    print(strongError.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: K.registerSegue, sender: self)
                }
            }
        }
    }
}
