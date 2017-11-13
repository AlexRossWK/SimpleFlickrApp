
import UIKit

private let imageCell = "OneImageCell"



//MARK: - VIEW LOADS AND OUTLETS
class OnePhotoCollectionView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if DataManager.shared.dataSource.count == 0 { getListRequest() } else { OnePhotoCollectionV.reloadData() }

    }


    
    @IBOutlet weak var OnePhotoCollectionV: UICollectionView!
    
    fileprivate let insetForSection: CGFloat = 1
    fileprivate let insetBetweenCells: CGFloat = 0
    fileprivate let numberOfItemsInLine = 1
    
}



//MARK: - COLLECTION VIEW DELEGATE

extension OnePhotoCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataManager.shared.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageCell, for: indexPath)
        
        let imageView = cell.contentView.viewWithTag(2) as! UIImageView
        let model = DataManager.shared.dataSource[indexPath.row]
        imageView.kf.setImage(with: URL(string: model.url ?? ""))
        
        
        return cell
    }
    

}




//MARK: - COLLECTION VIEW LAYOUT
extension OnePhotoCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = OnePhotoCollectionV.frame.width
        return CGSize(width: size, height: size)
 

    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return insetBetweenCells
    }


}


//MARK: - SEND REQUEST
extension OnePhotoCollectionView {
    
    fileprivate func getListRequest() {
        
        GetPopularPhotosManager.getList(success: { [weak self] (photos) in
            
            DispatchQueue.main.async { [weak self] in
                
                DataManager.shared.dataSource.removeAll()
                DataManager.shared.dataSource.append(contentsOf: photos)
                self?.OnePhotoCollectionV.reloadData()
                
            }
            
        }) { (requestError) in
            print(requestError)
        }
        
    }
    
}






