import UIKit
import Alamofire

class RecoverPasswordViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBOutlet weak var email_recovery_text: UITextField!
    
    @IBAction func recovery_password_button(_ sender: Any) {
        recoveryPassword(email: email_recovery_text.text!)
    }
    
    func recoveryPassword(email: String) {
        
        let url = URL(string: "http://localhost:8888/BienestarDigital/public/index.php/api/restorePassword")
        
        let json = ["_method": "PUT", "email": email]
        
        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: nil).responseJSON {
            (response) in
            
            switch(response.response?.statusCode){
            case 200:
                if let json = response.result.value as? [String: Any] {
                    
                    let token = json["token"] as! String
                    UserDefaults.standard.set(token, forKey: "token")
                    
                    self.performSegue(withIdentifier: "RecoveryPasswordSegue" , sender: nil)
                    
                }
            case 401:
                if let json = response.result.value as? [String: Any] {
                    
                    let message = json["message"] as! String
                    print(message)
                }
            default:
                print("nada")
                
            }
        }
    }
}
