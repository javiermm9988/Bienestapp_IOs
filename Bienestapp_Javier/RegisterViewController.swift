import UIKit
import Alamofire

class RegisterViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.register_error_text.isHidden = true
    }
    
    @IBOutlet weak var register_name: UITextField!
    @IBOutlet weak var register_email: UITextField!
    @IBOutlet weak var register_password: UITextField!
    @IBOutlet weak var register_error_text: UILabel!
    
    
    /// Botón que se encarga de la funcionalidad del registro
    ///
    /// - Parameter sender: <#sender description#>
    @IBAction func registerButton(_ sender: Any) {
        
        if register_name.text?.isEmpty ?? true || register_email.text?.isEmpty ?? true || register_password.text?.isEmpty ?? true
        {
            self.register_error_text.isHidden = false
        } else {
            registerUser(name: register_name.text!, email: register_email.text!, password: register_password.text!)
        }
    }
    
    /// Método que llama a la api para hacer el registro del usuario
    ///
    /// - Parameters:
    ///   - name: nombre en el formulario de registro
    ///   - email: email en el formulario de registro
    ///   - password: password en el formulario de registro
    func registerUser(name: String, email: String, password: String) {
        
        let url = URL(string: "http://localhost:8888/BienestarDigital/public/index.php/api/Register")!
        
        let json = ["name": name, "email": email, "password": password]
        
        Alamofire.request(url, method: .post, parameters: json, encoding: JSONEncoding.default, headers: nil).responseJSON {
            (response) in
            
            switch(response.response?.statusCode){
            case 200:
                if let json = response.result.value as? [String: Any] {
                    
                    let token = json["token"] as! String
                    UserDefaults.standard.set(token, forKey: "token")
                    
                    self.performSegue(withIdentifier: "RegisterEnterSegue" , sender: nil)
                    
                    print(token)
                    
                }
            case 401:
                if let json = response.result.value as? [String: Any] {
                    
                    let message = json["message"] as! String
                    self.register_error_text.text = message
                    self.register_error_text.isHidden = false
                    print(message)
                }
            default:
                print("nada")
                
            }
        }
    }
}
