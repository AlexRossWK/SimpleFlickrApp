
import Foundation


class PhotoCreaterManager {
    
    static func getSizeFor(photosArray: [PhotoModel], complete: @escaping ()->Void) {
        
        let countOfPhoto = photosArray.count
        var index = 0
        
        func getSize() {
            
            GetPhotoSizeManager.getSize(forPhoto: photosArray[index]) {
                index += 1
                if index != countOfPhoto { getSize() } else { complete() }
            }
            
        }
        
        getSize()
        
    }
    
}



extension PhotoCreaterManager {
    
    static func getFavoritesFor(photosArray: [PhotoModel], complete3: @escaping ()->Void) {
        
        let countOfPhoto = photosArray.count
        var index = 0
        
        func getFavorites() {
            
            
            GetPhotoFavoritesManager.getFavorites(forPhoto: photosArray[index]) {
                index += 1
                if index != countOfPhoto { getFavorites() } else { complete3() }
            }
            
            
            
        }
        
        getFavorites()
        
    }
    
    
    
}
