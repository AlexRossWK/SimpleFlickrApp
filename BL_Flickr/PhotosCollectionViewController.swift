

import UIKit
import Kingfisher

private let imageCell = "imageCell"


class PhotosCollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate let insetForSection: CGFloat = 1
    fileprivate let insetBetweenCells: CGFloat = 1
    fileprivate let numberOfItemsInLine = 3
    
}


//MARK: - VIEW LOADS
extension PhotosCollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if DataManager.shared.dataSource.count == 0 { getListRequest() } else { collectionView.reloadData() }
        
    }
    
}


//MARK: - COLLECTION VIEW DELEGATE
extension PhotosCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataManager.shared.dataSource.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageCell, for: indexPath)
        
        let imageView = cell.contentView.viewWithTag(1) as! UIImageView
        let model = DataManager.shared.dataSource[indexPath.row]
        imageView.kf.setImage(with: URL(string: model.url ?? ""))
        
        
        //для красоты (закругление, границы , цвет)
        cell.layer.borderWidth = 0.8
        cell.layer.cornerRadius = 3
        cell.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.layer.shadowOpacity = 0.7
        
        
        return cell
    }
    
}


//MARK: - COLLECTION VIEW LAYOUT
extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let inset = insetForSection*2 + CGFloat(numberOfItemsInLine-1) * insetBetweenCells
        let size = (collectionView.frame.width - inset) / CGFloat(numberOfItemsInLine) //- inset + 2   вот здесь была ошибка  ( не там вычли inset)
        
        return CGSize(width: size, height: size)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: insetForSection, left: insetForSection, bottom: insetForSection, right: insetForSection)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return insetBetweenCells
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return insetBetweenCells
    }
    
    
    
}



//MARK: - SEND REQUEST
extension PhotosCollectionViewController {
    
    fileprivate func getListRequest() {
        
        GetPopularPhotosManager.getList(success: { [weak self] (photos) in
            
            print("dsfsdgrgreg")
            
            DispatchQueue.main.async { [weak self] in
                
                DataManager.shared.dataSource.removeAll()
                DataManager.shared.dataSource.append(contentsOf: photos)
                self?.collectionView.reloadData()
                print(DataManager.shared.dataSource)
            }
            
        }) { (requestError) in
            print(requestError)
        }
        
    }
    
}




