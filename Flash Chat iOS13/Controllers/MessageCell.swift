
import UIKit

class MessageCell: UITableViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var messageBuble: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var leftImageView: UIImageView!
    
    // MARK: - lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        messageBuble.layer.cornerRadius = messageBuble.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
