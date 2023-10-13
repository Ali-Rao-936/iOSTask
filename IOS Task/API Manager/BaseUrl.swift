
import UIKit

class BaseUrl{
    public static let environment = Environment.Production
    
    private static let testBaseUrl = "https://newsapi.org/v2/"
    private static let stagingBaseUrl = "https://newsapi.org/v2/"
    private static let productionBaseUrl = "https://newsapi.org/v2/"
  
    
    class func getBaseUrl(apiType:ApiType) -> String
    {
        switch apiType{
        case .NEWS:
            switch environment {
                case .Test:
                    return testBaseUrl
                case .Staging:
                    return stagingBaseUrl
                case .Production:
                    return productionBaseUrl
            }
        
        }
       
    }
    
    enum ApiType{
        case NEWS
    }
}
