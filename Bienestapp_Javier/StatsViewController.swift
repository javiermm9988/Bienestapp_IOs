import UIKit
import Alamofire

class StatsViewController: UIViewController, UITableViewDelegate,
UITableViewDataSource {
    
    var jsonArray: NSArray?
    var nameArray: Array<String> = []
    var useArray: Array<String> = []
    @IBOutlet weak var usage_table_list: UITableView!
    
    @IBOutlet weak var segmented_control_index: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAppsDataDay()
    }
    
    @IBAction func segmented_control_changed(_ sender: Any) {
        switch segmented_control_index.selectedSegmentIndex {
        case 0:
            getAppsDataDay()
            break
        case 1:
            getAppsDataMonth()
            break
        case 2:
            getAppsDataYear()
            break
        default:
            print("Default")
        }
    }
    
    func getAppsDataDay() {
        let url = "http://localhost:8888/BienestarDigital/public/index.php/api/showAllAppUseToday"
        
        let userToken : String = UserDefaults.standard.value(forKey: "token") as! String
        let userTokenHeaders = ["Authorization" : userToken]
        
        Alamofire.request(url, headers:userTokenHeaders).responseJSON { response in
            if let JSON = response.result.value {
                self.jsonArray = JSON as? NSArray
                for item in self.jsonArray! as! [NSDictionary] {
                    
                    let name = item["name"] as? String
                    let use = item["use"] as? String
                    
                    self.nameArray.append((name)!)
                    self.useArray.append((use) ?? "0")
                }
                self.usage_table_list.reloadData()
            }
        }
    }
    
    func getAppsDataMonth(){
       
    }
    
    func getAppsDataYear(){
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsageCellList", for: indexPath) as! StatsListTableViewCell
        
        cell.name_stats_label.text = self.nameArray[indexPath.row]
        cell.usage_stats_label.text = self.useArray[indexPath.row]
        
        return cell
    }
}
