import UIKit

class AppsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    class App {
        var name = ""
        var usage = ""
    }
    
    var apps:[App] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let instagram = App()
        instagram.name = "Instagram"
        instagram.usage = "2h"
        
        let whatsapp = App()
        whatsapp.name = "Whatsapp"
        whatsapp.usage = "3h"
        
        let facebook = App()
        facebook.name = "Facebook"
        facebook.usage = "1h"
        
        apps = [instagram, whatsapp, facebook]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellAppList", for: indexPath) as! AppListTableViewCell
        cell.name_app_list.text = apps[indexPath.row].name
        cell.usage_app_list.text = apps[indexPath.row].usage
        //cell.image_app_list.image = UIImage(named: exercisesList[indexPath.row])
        
        //self.performSegue(withIdentifier: "AppCellEnterSegue" , sender: nil)
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
