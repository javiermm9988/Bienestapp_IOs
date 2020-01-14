import UIKit
import Alamofire

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBOutlet weak var email_login_text: UITextField!
    @IBOutlet weak var password_login_text: UITextField!
    

    @IBAction func login_button(_ sender: Any) {
        if email_login_text.text?.isEmpty ?? true || password_login_text.text?.isEmpty ?? true
        {
            
        } else {
            LoginUser(email: email_login_text.text!, password: password_login_text.text!)
        }
    }
    
    func LoginUser(email: String, password: String) {
        
        let url = URL(string: "")
        
        let json = ["email": email, "password": password]
        
        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: nil).responseJSON {
            (response) in
            
            switch(response.response?.statusCode){
            case 200:
                if let json = response.result.value as? [String: Any] {
                    
                    let token = json["token"] as! String
                    UserDefaults.standard.set(token, forKey: "token")
                    
                    self.performSegue(withIdentifier: "LoginEnterSegue" , sender: nil)
                    
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

