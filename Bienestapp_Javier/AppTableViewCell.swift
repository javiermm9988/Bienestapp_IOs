
import UIKit

class AppTableViewCell: UITableViewCell {

    @IBOutlet weak var icon_image_list: UIImageView!
    @IBOutlet weak var name_app_list: UILabel!
    @IBOutlet weak var usage_app_list: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
}
