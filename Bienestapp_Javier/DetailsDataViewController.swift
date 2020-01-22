import UIKit
import Alamofire

var global_id_app = ""

class DetailsDataViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUseAppsData()
    }
    
    @IBOutlet weak var total_use_label: UILabel!
    @IBOutlet weak var today_use_label: UILabel!
    @IBOutlet weak var yesterday_use_label: UILabel!
    @IBOutlet weak var beforeYes_use_label: UILabel!
    
    var jsonArray: NSArray?
    var totalUseSt: String = ""
    var todayUseSt: String = ""
    var yesterdayUseSt: String = ""
    var BeforeyesterdayUseSt: String = ""
    var idUseSt: String = ""
    
    
    func getUseAppsData() {
        let url = "http://localhost:8888/BienestarDigital/public/index.php/api/appUseDetails/"+global_name_app
        
        let userToken : String = UserDefaults.standard.value(forKey: "token") as! String
        let userTokenHeaders = ["Authorization" : userToken]
        
        Alamofire.request(url, headers:userTokenHeaders).responseJSON{ (response) in
            if let json = response.result.value {
                self.jsonArray = json as? NSArray
                for item in self.jsonArray as! [NSDictionary] {
                    let totalUse = item["TotalUse"] as? String
                    let todayUse = item["todayUse"] as? String
                    let yesterdayUse = item["yesterdayUse"] as? String
                    let befYesterdayUse = item["BYUse"] as? String
                    let id = item["id"] as? String
                    
                    self.totalUseSt = totalUse ?? "Sin uso"
                    self.todayUseSt = todayUse ?? "Sin uso"
                    self.yesterdayUseSt = yesterdayUse ?? "Sin uso"
                    self.BeforeyesterdayUseSt = befYesterdayUse ?? "Sin uso"
                    self.idUseSt = id ?? ""
                    
                    global_id_app = self.idUseSt
                    
                    self.total_use_label.text = self.totalUseSt
                    self.today_use_label.text = self.todayUseSt
                    self.yesterday_use_label.text = self.yesterdayUseSt
                    self.beforeYes_use_label.text = self.BeforeyesterdayUseSt
                    
                }
                self.tableView.reloadData()
            }
        }
    }
}
