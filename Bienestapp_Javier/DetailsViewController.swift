import UIKit

class DetailsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBOutlet weak var image_details: UIImageView!
    @IBOutlet weak var name_app_details: UILabel!
    @IBOutlet weak var usage_app_details: UILabel!
    
    @IBAction func returnToDetails(_ sender: UIStoryboardSegue) {}
}

