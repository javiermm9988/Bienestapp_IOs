import UIKit

class TimerControlViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func save_changes_details(_ sender: Any) {
        self.performSegue(withIdentifier: "returnDetails", sender: nil)
    }
    
}
