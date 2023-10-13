

import Foundation
import UIKit
import CommonCrypto

extension String
{
    
    func width(forHeight height: CGFloat, font: UIFont) -> CGFloat {
            let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
            let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)

            return ceil(boundingBox.width)
        }
    
    func isMobileNumber()-> Bool
    {
        return self.first == "5" &&  self.count == 9
//            self.substring(from: 1, to: 1) == "5"
    }
    
    var localized: String{
        return NSLocalizedString(self, comment: "")
    }
    
    func trim() -> String
    {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
    func trimAll() -> String
    {
        return String(self.filter { !" \n\t\r".contains($0) })
    }
    func trimAl() -> String
    {
        return String(self.filter { !" \n".contains($0) })
    }
    
    var isNumeric: Bool {
        let string = self.trim().trimAll()
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(string).isSubset(of: nums)
    }
    
    func isEmailID() -> Bool
    {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
    
    func substring(from: Int?, to: Int?) -> String {
        if let start = from {
            guard start < self.count else {
                return ""
            }
        }
        if let end = to {
            guard end >= 0 else {
                return ""
            }
        }
        if let start = from, let end = to {
            guard end - start >= 0 else {
                return ""
            }
        }
        let startIndex: String.Index
        if let start = from, start >= 0 {
            startIndex = self.index(self.startIndex, offsetBy: start)
        } else {
            startIndex = self.startIndex
        }
        let endIndex: String.Index
        if let end = to, end >= 0, end < self.count {
            endIndex = self.index(self.startIndex, offsetBy: end + 1)
        } else {
            endIndex = self.endIndex
        }
        return String(self[startIndex ..< endIndex])
    }
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}
extension String {
    
    func sha1() -> String {
        let data = Data(self.utf8)
        var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA1($0.baseAddress, CC_LONG(data.count), &digest)
        }
        let hexBytes = digest.map { String(format: "%02hhx", $0) }
        return hexBytes.joined()
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    func getFormattedDate(from inputDateformat: String, andConvertTo outputDateFormat: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = inputDateformat
        guard let date = formatter.date(from: self) else { return "" }

        formatter.dateFormat = outputDateFormat
        let outputDate = formatter.string(from: date)
        return outputDate
    }
    
    subscript(idx: Int) -> String {
          String(self[index(startIndex, offsetBy: idx)])
      }
    
}

extension LosslessStringConvertible {
    var string: String { .init(self) }
}

extension URL {
    var typeIdentifier: String? {
        return (try? resourceValues(forKeys: [.typeIdentifierKey]))?.typeIdentifier
    }
    var localizedName: String? {
        return (try? resourceValues(forKeys: [.localizedNameKey]))?.localizedName
    }
}


extension Double{
    func round(to places: Int) -> Double {
            let divisor = pow(10.0, Double(places))
            return (self * divisor).rounded() / divisor
        }
}

extension NSDate {
    func dateStringWithFormat(format: String) -> String {
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format
        return dateFormatter.string(from: self as Date)
        }
}
