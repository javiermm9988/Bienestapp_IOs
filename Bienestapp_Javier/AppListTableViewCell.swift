import UIKit

class AppListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name_app_list: UILabel!
    @IBOutlet weak var usage_app_list: UILabel!
    @IBOutlet weak var image_app_list: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
