import UIKit
import Alamofire

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.email_login_text.text = "javimm988@gmail.com"
        self.password_login_text.text = "1234"
        
    }
    
    @IBOutlet weak var email_login_text: UITextField!
    @IBOutlet weak var password_login_text: UITextField!
    

    /// Función al pulsar el botón de login y hacer su funcionalidad
    ///
    /// - Parameter sender: <#sender description#>
    @IBAction func login_button(_ sender: Any) {
        if email_login_text.text?.isEmpty ?? true || password_login_text.text?.isEmpty ?? true
        {
            
        } else {
            LoginUser(email: email_login_text.text!, password: password_login_text.text!)
        }
    }
    
    /// Función que llama al metodo de la api que se encarga de hacer login
    ///
    /// - Parameters:
    ///   - email: email del login
    ///   - password: password del login
    func LoginUser(email: String, password: String) {
        
        let url = URL(string: "http://localhost:8888/BienestarDigital/public/index.php/api/Login")
        
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

