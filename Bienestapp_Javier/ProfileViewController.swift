import UIKit
import Alamofire

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUsersData()
    }
    
    @IBOutlet weak var name_label: UILabel!
    @IBOutlet weak var email_label: UILabel!
    
    func getUsersData() {
        let url = "http://localhost:8888/BienestarDigital/public/index.php/api/ShowData"
        
        let userToken : String = UserDefaults.standard.value(forKey: "token") as! String
        let userTokenHeaders = ["Authorization" : userToken]
        
        Alamofire.request(url, headers:userTokenHeaders).responseJSON { (response) in
            if let json = response.result.value as? [String: Any] {
                
                self.name_label.text = json["name"]! as? String
                self.email_label.text = json["email"] as? String
                
            }
        }
    }
}
