import UIKit
import Alamofire
import AlamofireImage

var global_name_app = ""
var global_icon_app = ""

class AppsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table_view: UITableView!
    var jsonArray: NSArray?
    var nameArray: Array<String> = []
    var useArray: Array<String> = []
    var iconURLArray: Array<String> = []
    var DetailsViewController : UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAppsData()
    }
    
    /// Obtiene los datos del tiempo de uso de las aplicaciones y los añade a la lista
    func getAppsData() {
        let url = "http://localhost:8888/BienestarDigital/public/index.php/api/showAllAppUseToday"
        
        let userToken : String = UserDefaults.standard.value(forKey: "token") as! String
        let userTokenHeaders = ["Authorization" : userToken]
        
        Alamofire.request(url, headers:userTokenHeaders).responseJSON { response in
            if let JSON = response.result.value {
                self.jsonArray = JSON as? NSArray
                for item in self.jsonArray! as! [NSDictionary] {
                    
                    let name = item["name"] as? String
                    let use = item["use"] as? String
                    let iconURL = item["icon"] as? String
                    
                    self.nameArray.append((name)!)
                    self.useArray.append((use) ?? "0")
                    self.iconURLArray.append((iconURL)!)
                }
                self.table_view.reloadData()
            }
        }
    }
    
    /// Los siguientes métodos añaden los datos a las celdas de la vista de los tiempos de uso de las apps

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellAppList", for: indexPath) as! AppListTableViewCell
        
        cell.name_app_list.text = self.nameArray[indexPath.row]
        cell.usage_app_list.text = self.useArray[indexPath.row]
        
        let url = URL(string: self.iconURLArray[indexPath.row])
        cell.image_app_list.af_setImage(withURL: url!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let name_app = nameArray[indexPath.row]
        global_name_app = name_app
        
        let icon_app = iconURLArray[indexPath.row]
        global_icon_app = icon_app
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
