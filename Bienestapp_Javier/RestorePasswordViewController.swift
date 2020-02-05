import UIKit
import Alamofire

class RestorePasswordViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBOutlet weak var old_password_text: UITextField!
    @IBOutlet weak var new_password_text: UITextField!
    @IBOutlet weak var confirm_password_text: UITextField!
    
    @IBAction func restore_password_button(_ sender: Any) {
        restorePassword(currentPassword: old_password_text.text!, newPassword: new_password_text.text!, confirmPassword: confirm_password_text.text!)
    }
    
    /// Método para cambiar la contraseña por una nueva
    ///
    /// - Parameters:
    ///   - currentPassword: password inicial
    ///   - newPassword: password nueva
    ///   - confirmPassword: confirmación de la contraseña nueva
    func restorePassword(currentPassword: String, newPassword: String, confirmPassword: String) {
        
        let url = URL(string: "http://localhost:8888/BienestarDigital/public/index.php/api/editPassword")
        
        let userToken : String = UserDefaults.standard.value(forKey: "token") as! String
        let userTokenHeaders = ["Authorization" : userToken]
        
        let json = ["_method": "PUT", "currentPassword": currentPassword, "newPassword": newPassword, "confirmPassword": confirmPassword]
        
        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: userTokenHeaders).responseJSON {
            (response) in
            
            switch(response.response?.statusCode){
            case 200:
                self.performSegue(withIdentifier: "return_profile_segue", sender: nil)
            case 401:
                if let json = response.result.value as? [String: Any] {
                    let message = json["message"] as! String
                    print(message)
                }
            default:
                print("DEFAULT")
                
            }
        }
    }
}
