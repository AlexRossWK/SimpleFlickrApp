
import UIKit

private let photoCell = "photoCell"

class PhotosListViewController: UIViewController {
    
    //MARK: - IB OUTLETS
    @IBOutlet weak var tableView: UITableView!
    let refreshControl = UIRefreshControl()
    
    
    //MARK: - VARS
    fileprivate var photosArray = [PhotoModel]()
    fileprivate var didUpdate = false
}


//MARK: - VIEW LOADS
extension PhotosListViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(UINib(nibName: "PhotoTableViewCell", bundle: nil), forCellReuseIdentifier: photoCell)
        
        refreshControl.addTarget(self, action: #selector(getListRequest), for: .valueChanged)
        refreshControl.tintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        refreshControl.attributedTitle = NSAttributedString(string: "Waiting")
        tableView.addSubview(refreshControl)
        
        getListRequest()
        
        
    }
    
}


//MARK: - TABLE VIEW
extension PhotosListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: photoCell, for: indexPath) as! PhotoTableViewCell
        
        cell.configure(withModel: photosArray[indexPath.row], andTableView: tableView)
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if !didUpdate && indexPath.row == photosArray.count - 1 {
            getSizesRequest()
            getFavoritesRequest()
        }
        
    }
    
}


//MARK: - SEND REQUESTS
extension PhotosListViewController {
    
    @objc fileprivate func getListRequest() {
        
        GetPopularPhotosManager.getList(success: { [weak self] (photos) in
            
            DispatchQueue.main.async { [weak self] in
                self?.refreshControl.endRefreshing()
            }
            self?.didUpdate = false
            DataManager.shared.dataSource.removeAll()
            DataManager.shared.dataSource.append(contentsOf: photos)
            self?.getSizesRequest()
            self?.getFavoritesRequest()
            
        }) { (requestError) in
            print(requestError)
        }
        
    }
    
    
    
    
    
    fileprivate func getSizesRequest() {
        
        var arrayOfPhotosForRequest = [PhotoModel]()
        let finalIndex = photosArray.count + Const.AppConst.countOfPhotosForRequest
        
        if finalIndex > DataManager.shared.dataSource.count { didUpdate = true; return }
        
        arrayOfPhotosForRequest.append(contentsOf: DataManager.shared.dataSource[photosArray.count ..< finalIndex])
        
        PhotoCreaterManager.getSizeFor(photosArray: arrayOfPhotosForRequest) { [weak self] in
            
            
            DispatchQueue.main.async { [weak self] in
                
                self?.photosArray.append(contentsOf: arrayOfPhotosForRequest)
                self?.tableView.reloadData()
                
            }
            
        }
        
    }
    
    
    
    fileprivate func getFavoritesRequest(){
        
        var arrayOfPhotosForRequest = [PhotoModel]()
        let finalIndex = photosArray.count + Const.AppConst.countOfPhotosForRequest
        if finalIndex > DataManager.shared.dataSource.count { didUpdate = true; return }
        arrayOfPhotosForRequest.append(contentsOf: DataManager.shared.dataSource[photosArray.count ..< finalIndex])
        
        PhotoCreaterManager.getFavoritesFor(photosArray: arrayOfPhotosForRequest) { [weak self] in
            
            DispatchQueue.main.async { [weak self] in
                
                self?.photosArray.append(contentsOf: arrayOfPhotosForRequest)
                self?.tableView.reloadData()
                
                
            }
            
            
        }
        
        
    }
}
