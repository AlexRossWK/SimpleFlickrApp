

import SwiftyJSON


class GetPhotoSizeManager {
    
    static func getSize(forPhoto model: PhotoModel, complete: @escaping ()->Void) {
        
        API_WRAPPER.getPhotoSize(photoId: model.photoId, success2: { (reponse) in
            
            let jsonResponse = JSON(reponse)
            
            for size in jsonResponse["sizes"]["size"].arrayValue {
                
                if size["label"] == "Medium 640" {
                    
                    let width = size["width"].doubleValue
                    let height = size["height"].doubleValue
                    model.size = CGSize(width: width, height: height)
                    break
                    
                }
                
            }
            
            complete()
            
        }) { (requestError) in
            print(requestError)
        }
        
    }
    
}
