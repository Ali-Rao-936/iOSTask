

import UIKit
import Reachability
import ProgressHUD
import CoreLocation
import UserNotifications
import StoreKit

class Utility: NSObject {
    
    
    enum dateFormat: String {
        case yyyyMMddHHmm = "yyyy-MM-dd HH:mm" 
        case yyyyMMddHHmmss = "yyyy-MM-dd HH:mm:ss"  // 2023-04-30 16:00:00 
        case ddMMyyyyWithTimeZone = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        case ddMMyyyyTimeZone = "yyyy-MM-dd HH:mm:ss.SSS"
     
    }
    

    class func getPlaceHolder()-> UIImage?
    {
        return UIImage.init(named: "noImage")
    }
  
    
    class func formatDate(date: Date?, with outputFormat: dateFormat)-> String
    {
        if date == nil
        {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = outputFormat.rawValue
        dateFormatter.locale = Locale(identifier: "en")
        return dateFormatter.string(from: date!)
    }
   
    
    class func isNetworkConnected() -> Bool
    {
        let reachability = try! Reachability()
        return reachability.connection != .unavailable
    }
    
    class func showSuccessSnackView(message: String, iconName: String)
    {
        SnackView().showSuccessSnackView(withMessage: message, iconName: iconName)
    }
    class func showSuccessSnackViewWithCompletion(message: String, iconName: String,color:UIColor = UIColor.init(hex: "00ad00"),callback:@escaping(()->Void))
    {
        SnackView().showSnackViewWithCompletion(withMessage: message, iconName: iconName,color:color, dissmiss: callback)
    }
   
    
    class func showErrorSnackView(message: String)
    {
        SnackView().showErrorSnackView(withMessage: message)
    }
    
    class func showProgress() {
        DispatchQueue.main.async {
            ProgressHUD.colorBackground = UIColor.black.withAlphaComponent(0.2)
            ProgressHUD.colorHUD = Colors.accentColor()
            ProgressHUD.colorHUD = .systemGray
            ProgressHUD.colorAnimation = UIColor(named: "TextColor")!
            ProgressHUD.show("Loading...".localized, interaction: false)
        }
    }
    
    class func showProgress(progress: Float) {
        DispatchQueue.main.async {
            ProgressHUD.colorBackground = UIColor.black.withAlphaComponent(0.2)
            ProgressHUD.colorHUD = Colors.accentColor()
            ProgressHUD.colorAnimation = Colors.accentColor()
            ProgressHUD.colorProgress = Colors.accentColor()
            ProgressHUD.showProgress(CGFloat(progress), interaction: false)
        }
    }
    
    class func dismissProgress() {
        DispatchQueue.main.async {
            ProgressHUD.dismiss()
        }
    }
    

    
    class func openUrl(url: URL)
    {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, completionHandler: { (success) in
            })
        }
    }
    

   
   class func setDateFormat(dateValue : String, fromDateFormat : String, toDateFormat : dateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromDateFormat
     return  Utility.formatDate(date: dateFormatter.date(from:dateValue), with: toDateFormat)
    }
    
    
    class func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
  
    
    static func timeInMins(date: String) -> String{
        if(date == ""){
            return ""
        }
    
        // Create Date Formatter
        let dateFormatter = DateFormatter()

        // Set Date Format
        dateFormatter.dateFormat = Utility.dateFormat.ddMMyyyyWithTimeZone.rawValue

        // Convert String to Date
        let d =   dateFormatter.date(from: date)
        
        return d?.timeAgoDisplay() ?? ""
    }
    
    
}
