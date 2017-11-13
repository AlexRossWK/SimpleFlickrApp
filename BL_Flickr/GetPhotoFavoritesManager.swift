

import Foundation
import SwiftyJSON


class GetPhotoFavoritesManager {
    
    static func getFavorites(forPhoto model: PhotoModel, complete3: @escaping ()->Void){
        
        API_WRAPPER.getPhotoFavorites(photoId: model.photoId, success3: { (response3) in
            
            let jsonResponse = JSON(response3)
            
            let favorite = jsonResponse["photo"]["total"].intValue
            
            model.favorites = favorite
            
            complete3()
            
            
            
            
        }) { (requestError) in
            print(requestError)
        }
        
        
        
    }
    
    
    
    
    
    
}
