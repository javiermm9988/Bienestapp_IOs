import UIKit

class DetailsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.name_app_details.text = global_name_app
        let url = URL(string: global_icon_app)
        image_details.af_setImage(withURL: url!)
        
    }
    
    @IBOutlet weak var image_details: UIImageView!
    @IBOutlet weak var name_app_details: UILabel!
    
    
    
    @IBAction func returnToDetails(_ sender: UIStoryboardSegue) {}
}

