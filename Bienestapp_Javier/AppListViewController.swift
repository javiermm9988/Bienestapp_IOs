import UIKit

class AppListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    class App {
        var name = ""
        var use = ""
    }
    
    var apps:[App] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let instagram = App()
        instagram.name = "Instagram"
        instagram.use = "1.3h"
        
        let whatsapp = App()
        whatsapp.name = "Whatsapp"
        whatsapp.use = "2h"
        
        let facebook = App()
        facebook.name = "Facebook"
        facebook.use = "1h"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellAppList", for: indexPath) as! AppListTableViewCell
        
        cell.name_app_list.text = apps[indexPath.row].name
        cell.usage_app_list.text = apps[indexPath.row].use
        //cell.imageCell.image = UIImage(named: exercisesList[indexPath.row])
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
