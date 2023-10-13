

import UIKit
import Reachability
import ProgressHUD
import CoreLocation
import UserNotifications
import StoreKit

class Utility: NSObject {
    
    
    enum dateFormat: String {
        case ddMMyyyyWithTimePretty = "dd-MM-yyyy HH:mm:ss"
        
        case ddMMyyyyWithTime = "yyyy-MM-dd'T'HH:mm:ss"
                   //          2023/03/15 8:00:00
        case ddMMyyyyHHmm = "yyyy/MM/dd HH:mm:ss"
        case yyyyMMddHHmm = "yyyy-MM-dd HH:mm" 
        case yyyyMMddHHmmss = "yyyy-MM-dd HH:mm:ss"  // 2023-04-30 16:00:00 
        case ddMMyyyyWithTimeZone = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" //2023-07-24T12:11:40.000000Z
        case ddMMyyyyTimeZone = "yyyy-MM-dd HH:mm:ss.SSS"   // 2018-08-01 00:00:00.000
        case ddMMMyyyy = "dd-MMM-yyyy"
        case ddMMyyyy = "dd-MM-yyyy"
        case yyyyMMdd = "yyyy-MM-dd"
        case dd = "dd"
        case MMM = "MMM"
        case hhmma = "hh:mm a"
        case yyyy = "yyyy"
        case eeee = "EEEE"
        case eee = "EEE"
        case hhmm = "H.mm"
        case hhmm2 = "HH:mm"
        case hhmmxm = "HH:MM XM"
        case eddmmm = "E, d MMM"
        case edmmmHHmm = "E, d MMM HH:mm"
        case ddsmmmsyyyy = "dd MMM yyyy"
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
    
    
    class func changeNameOfDay(name_of_day:String)-> String
    {
        var name_of_day_after_change:String = "nil"
        
        switch name_of_day {
                case "Sat" :
                    name_of_day_after_change = "Sa"
                case "Sun" :
                    name_of_day_after_change = "Su"
                case "Mon" :
                    name_of_day_after_change = "M"
                case "Tue" :
                    name_of_day_after_change = "Tu"
                case "Wed" :
                    name_of_day_after_change = "W"
                case "Thu" :
                    name_of_day_after_change = "Tu"
                case "Fri" :
                    name_of_day_after_change = "F"
                default:
                    name_of_day_after_change = "S"
                }
        
        return name_of_day_after_change
    }
    
   
    
    class func timeStampToDateString(timeStamp: Double, with outputFormat: dateFormat)-> String
    {
        let date = Date(timeIntervalSince1970: timeStamp/1000)
       
        return formatDate(date: date, with: outputFormat)
    }
    
    class func timeStampToRelativeTime(timeStamp: Double) -> String{
        
        let date = Date(timeIntervalSince1970: timeStamp/1000)

        // ask for the full relative date
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full

        // get exampleDate relative to the current date
        var relativeDate = formatter.localizedString(for: date, relativeTo: Date())

        // print it out
        print("Relative date is: \(relativeDate)")
        if relativeDate == "in 0 seconds"{
            relativeDate = "Just now"
        }
        return relativeDate
    }
    
    class func getCurrentTimeStamp()-> String
    {
        return "\(Int(Date().timeIntervalSince1970 * 1000))"
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
    
    
  
    
    class func getJson(obj:Any)->String{
            let jsonData = try! JSONSerialization.data(withJSONObject: obj)
        let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)
                            print(jsonString ?? "")
            return String(jsonString ?? "")
    }
    
   
    
    class func getFormattedDateTime(dateTime : String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        if let date = dateFormatterGet.date(from: dateTime) {
            return dateFormatterPrint.string(from: date)
        } else {
            return ""
        }
    }
    
    class func getSystemTimeZoneTime(dateString:String)->Date{
       let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
       guard let date = dateFormatter.date(from: dateString) else{return Date()}
            let source_timezone = NSTimeZone(abbreviation: "GMT+08")
       let local_timezone = NSTimeZone.system
       let source_EDT_offset = source_timezone?.secondsFromGMT(for: date)
            let destination_EDT_offset = local_timezone.secondsFromGMT(for: date)
       let time_interval : TimeInterval = Double(destination_EDT_offset - source_EDT_offset!)
       let convertedDate = NSDate(timeInterval: time_interval, since: date)
        return convertedDate as Date
    }
    
    class func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
  
    
//    class func gotoHome(){
//        let homeNav = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBar")
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.window?.rootViewController = homeNav
//    }
    
    
    static func timeInMins(startDate: String) -> Double{
        if(startDate == ""){
            return 0.0
        }
        else{
            let date = Date().localDate()
            
            let dateFormatter = DateFormatter()
            let dateFormatter1 = DateFormatter()
            
            dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
            dateFormatter1.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            // let CDate = dateFormatter1.date(from: date)!
            let SDate = dateFormatter.date(from: startDate)!
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
            let timeInterval = date.timeIntervalSince(SDate)
            var hours = timeInterval / 3600
            // print("Hours: \(hours)")
            let hoursDouble = Double(hours)
            hours = hoursDouble.round(to:2)
            
            // return hours
            // print("HoursAfter: \(hours)")
            var minutes = hours * 60//(timeInterval - hours * 3600) / 60
            minutes = minutes.round(to: 0)
            
            return minutes
        }
    }
    
    
}
