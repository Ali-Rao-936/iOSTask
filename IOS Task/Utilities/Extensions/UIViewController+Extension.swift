

import UIKit

extension UIViewController
{

    func showMessagePrompt(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
      }
    
    func openVC(storyBoard:String,identifier:String){
        let vc = UIStoryboard(name: storyBoard, bundle: nil).instantiateViewController(withIdentifier: identifier)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func setBackButton(){
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        btn.setImage(UIImage(named: "Back"), for: .normal)
        btn.addTarget(self, action: #selector(actionBack), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
    }
    func getButton(image:UIImage?)->UIButton{
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        btn.setImage(image, for: .normal)
        return btn
    }
    
    func getBackButton(image:UIImage?)->UIButton{
        let btn = getButton(image: image)
        btn.addTarget(self, action: #selector(actionBack), for: .touchUpInside)
        return btn
    }
    
    @objc func actionBack(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func setupNavBar(name : String){
        self.navigationItem.titleView = getHeaderLabel(title: name)
    }
    
    func getHeaderLabel(title:String) -> UILabel{
     //   let w = title.width(forHeight: 18, font: UIFont(name: "Urbanist-Bold", size: 18)!)
        let w = title.width(forHeight: 18, font: .systemFont(ofSize: 18, weight: .bold))
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: w, height: 18))
        label.text = title
        label.font = UIFont(name: "Urbanist-Bold", size: 18)
        label.textColor = .black
        return label
    }
    
    
    func statusBarColor(){
            if #available(iOS 13.0, *) {
               let app = UIApplication.shared
               let statusBarHeight: CGFloat = app.statusBarFrame.size.height

               let statusbarView = UIView()
               statusbarView.backgroundColor = Colors.primaryColor()
               view.addSubview(statusbarView)

               statusbarView.translatesAutoresizingMaskIntoConstraints = false
               statusbarView.heightAnchor
                 .constraint(equalToConstant: statusBarHeight).isActive = true
               statusbarView.widthAnchor
                 .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
               statusbarView.topAnchor
                 .constraint(equalTo: view.topAnchor).isActive = true
               statusbarView.centerXAnchor
                 .constraint(equalTo: view.centerXAnchor).isActive = true

            } else {
                  let statusBar = UIApplication.shared.value(forKeyPath:
               "statusBarWindow.statusBar") as? UIView
                statusBar?.backgroundColor = Colors.primaryColor()
            }

        }
}
