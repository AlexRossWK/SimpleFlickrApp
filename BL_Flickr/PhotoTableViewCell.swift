

import UIKit
import Kingfisher


class PhotoTableViewCell: UITableViewCell {

    
    @IBOutlet fileprivate weak var photoImageView: UIImageView!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var photoHeightConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var favoritesLabel: UILabel!
    
    
}


//MARK: - PREPARE FOR REUSE
extension PhotoTableViewCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
}


//MARK: - CONFIGURE
extension PhotoTableViewCell {
    
    func configure(withModel model: PhotoModel, andTableView tableView: UITableView) {
        
        photoHeightConstraint.constant = getHeightFor(model: model)
        photoImageView.layoutIfNeeded()
        self.layoutIfNeeded()
        photoImageView.kf.setImage(with: URL(string: model.url ?? ""), placeholder: nil, options: nil, progressBlock: nil) { (image, _, cache, _) in
            
            
        }
        
        titleLabel.text = model.title
        favoritesLabel.text = "Likes❤️:\(String(describing: model.favorites ?? 0))"
        favoritesLabel.textColor = UIColor.white
    }
    
}


//MARK: - GET PHOTO SIZE
fileprivate extension PhotoTableViewCell {
    
    func getHeightFor(model: PhotoModel) -> CGFloat {
        return self.frame.width / (model.size!.width / model.size!.height )
    }
    
}






// I needed to find a reason of a mistake
extension NSLayoutConstraint {
    
    override open var description: String {
        let id = identifier ?? ""
        return "id: \(id), constant: \(constant)"
    }
}


