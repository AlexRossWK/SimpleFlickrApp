

import UIKit

//MARK: - PRIVATE FUNCS
struct API_WRAPPER {
    
}


//MARK: - GET PHOTO REQUESTS
extension API_WRAPPER {
    
    static func getPopularPhotosList(success1 : @escaping (_ json : Any) -> Void, failure : @escaping (_ errorDescription : String) -> Void) -> URLSessionDataTask {
        
        //URL with params
        let url = Const.API_URLS.baseURL
        let params : [String: Any] = ["method" : "flickr.interestingness.getList",
                                      "api_key" : Const.API_params.apiKey,
                                      "format": "json",
                                      "nojsoncallback": 1]
        
        
        let request = API_Configurator.createRequest(withURL: url, andParams: params)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            API_Configurator.generalCompletionHandler(withData: data, withError: error, success: success1, failure: failure)
        }
        
        dataTask.resume()
        
        return dataTask
    }
    
}


//MARK: - GET PHOTO SIZES 
extension API_WRAPPER {
    
    static func getPhotoSize(photoId: String, success2 : @escaping (_ json : Any) -> Void, failure : @escaping (_ errorDescription : String) -> Void) {
    
        let url = Const.API_URLS.baseURL
        let params: [String: Any] = ["method": "flickr.photos.getSizes",
                                     "api_key": Const.API_params.apiKey,
                                     "photo_id": photoId,
                                     "format": "json",
                                     "nojsoncallback": 1]
        
        let request = API_Configurator.createRequest(withURL: url, andParams: params)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            API_Configurator.generalCompletionHandler(withData: data, withError: error, success: success2, failure: failure)
        }
        
        dataTask.resume()
    }
    
}




//MARK: - GET PHOTO FAVORITES
extension API_WRAPPER {
    
    static func getPhotoFavorites(photoId: String, success3 : @escaping (_ json : Any) -> Void, failure : @escaping (_ errorDescription : String) -> Void) {
        
        let url = Const.API_URLS.baseURL
        let params: [String: Any] = ["method": "flickr.photos.getFavorites",
                                     "api_key": Const.API_params.apiKey,
                                     "photo_id": photoId,
                                     "format": "json",
                                     "nojsoncallback": 1]
        let request = API_Configurator.createRequest(withURL: url, andParams: params)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            API_Configurator.generalCompletionHandler(withData: data, withError: error, success: success3, failure: failure)
        }
        
        dataTask.resume()
    }
    
}







