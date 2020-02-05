import UIKit
import Alamofire

class StatsListTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var name_stats_label: UILabel!
    @IBOutlet weak var usage_stats_label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
}
