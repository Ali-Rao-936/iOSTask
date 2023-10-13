

import UIKit
import Alamofire
import SwiftyJSON


class WebService {
    func get(url: String, params: Dictionary<String, Any>?, completion: @escaping (JSON?) -> Void, failed: @escaping (String) -> Void)
    {
        webService(url: url, method: .get, params: params, completion: completion, failed: failed)
    }

    
    
    private func webService(url: String, method: Alamofire.HTTPMethod, params: Dictionary<String, Any>?, completion: @escaping (JSON?) -> Void, failed: @escaping (String) -> Void)
    {
     print(url)
        if(Utility.isNetworkConnected()){
            URLCache.shared.removeAllCachedResponses()
            var encoding: ParameterEncoding?
            if(method == .get)
            {
                encoding = URLEncoding.default
            }
            else
            {
                encoding = JSONEncoding.default
            }
            AF.request(url, method: method,
                          parameters: params,
                          encoding: encoding!,
                          headers: self.getHeaders(url: url))
                .validate(statusCode: 200...299)
                .responseJSON(completionHandler: { (response) in
                    self.handleResponse(response: response, completion: completion, failed: failed)
            })
        }
        else{
            Utility.dismissProgress()
            failed("No network")
            return
        }
    }
    
  
    
    private func handleResponse(response: AFDataResponse<Any>, completion: @escaping (JSON?) -> Void, failed: @escaping (String) -> Void)
    {
        Utility.dismissProgress()
        switch response.result {
            case .success:
                if let value = response.value as? [String: AnyObject] {
                    completion(JSON(value))
                }
                else if let array = response.value as? Array<Any>
                {
                    completion(JSON(array))
                }
                else
                {
                    failed("Please try again later")
                    return
                }
            case .failure(_):
            if response.response?.statusCode == 401{
                //handleSessionOut()
                failed("Invalid Credentials")
                return
            }
                if let value = response.data?.toDictionary() {
                    if let message = value["message"] as? String
                    {
                        failed(message)
                    }
                    else {
                        failed("Please try again later")
                    }
                }
                else
                {
                    failed("Please try again later")
                    return
                }
            }
    }
    
    private func getHeaders(url urlString: String) -> HTTPHeaders{
        var headers: HTTPHeaders = HTTPHeaders()
        headers["Accept"] = "application/json"

        return headers
    }
    
//    func handleSessionOut(){
//        Utility.showSuccessSnackViewWithCompletion(message: "Session Out! Please Login to Countinue", iconName: "",color: UIColor.init(hex: "ba000d")) {
//            AppPreferences.clearUserData()
//            Utility.gotoHome()
//        }
//
//    }
}
