
import Foundation
import Kingfisher



extension URL
{
    func getImage(imageCompletionHandler: @escaping (UIImage) -> Void)
    {
        KingfisherManager.shared.retrieveImage(with: self, options: nil, progressBlock: nil) { result in
            switch result {
            case .success(let value):
                imageCompletionHandler(value.image)
            case .failure:
                imageCompletionHandler(Utility.getPlaceHolder()!)
            }
        }
    }
}

extension UITableView {
    func scrollToBottom(isAnimated:Bool = true){

           DispatchQueue.main.async {
               let indexPath = IndexPath(
                   row: self.numberOfRows(inSection:  self.numberOfSections-1) - 1,
                   section: self.numberOfSections - 1)
               if self.hasRowAtIndexPath(indexPath: indexPath) {
                   self.scrollToRow(at: indexPath, at: .bottom, animated: isAnimated)
               }
           }
       }
    
    func scrollToTop(isAnimated:Bool = true) {

            DispatchQueue.main.async {
                let indexPath = IndexPath(row: 0, section: 0)
                if self.hasRowAtIndexPath(indexPath: indexPath) {
                    self.scrollToRow(at: indexPath, at: .top, animated: isAnimated)
               }
            }
        }

        func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
            return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
        }
}
