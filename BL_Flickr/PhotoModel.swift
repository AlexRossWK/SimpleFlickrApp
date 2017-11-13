

import UIKit


class PhotoModel {
    
    let owner: String
    let secret: String
    let server: String
    let photoId: String
    let farm: Int
    let title: String? 
    var url: String?
    
    var size: CGSize?
    
    var favorites: Int?
    
    init(owner: String, secret: String, server: String, photoId: String, farm: Int, title: String?) {
        
        self.owner = owner
        self.secret = secret
        self.server = server
        self.photoId = photoId
        self.farm = farm
        self.title = title
        
    }
    
}
