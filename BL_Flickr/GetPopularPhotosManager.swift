
import SwiftyJSON


class GetPopularPhotosManager {
    
    static func getList(success: @escaping (_ photos: [PhotoModel] ) -> Void, failure: @escaping (_ errorDescription: String) -> Void) {
        
        _ = API_WRAPPER.getPopularPhotosList(success1: { (response) in
            
            var photosArray = [PhotoModel]()
            let jsonResponse = JSON(response)
            
            let arrayOfJSONPhotos = jsonResponse["photos"]["photo"].arrayValue
            
            for photo in arrayOfJSONPhotos {
                
                let owner = photo["owner"].stringValue
                let secret = photo["secret"].stringValue
                let server = photo["server"].stringValue
                let photoId = photo["id"].stringValue
                let farm = photo["farm"].intValue
                let title = photo["title"].string
                
                let newPhoto = PhotoModel(owner: owner, secret: secret, server: server, photoId: photoId, farm: farm, title: title)
                
                newPhoto.url = API_Configurator.createImgURL(object: newPhoto)
                
                photosArray.append(newPhoto)
                
            }
            
            success(photosArray)
            
            
        }) { (errorDescrption) in
            
            failure(errorDescrption)
            
        }
        
    }
    
}
