

import UIKit

extension UIViewController
{
    func colorSection(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cornerRadius: CGFloat = 10.0
        cell.backgroundColor = UIColor.clear
        let layer: CAShapeLayer = CAShapeLayer()
        let pathRef: CGMutablePath = CGMutablePath()
        //dx leading an trailing margins
        let bounds: CGRect = cell.bounds.insetBy(dx: 0, dy: 0)
        var addLine: Bool = false
        
        if indexPath.row == 0 && indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            pathRef.__addRoundedRect(transform: nil, rect: bounds, cornerWidth: cornerRadius, cornerHeight: cornerRadius)
        } else if indexPath.row == 0 {
            pathRef.move(to: CGPoint(x: bounds.minX, y: bounds.maxY))
            pathRef.addArc(tangent1End: CGPoint(x: bounds.minX, y: bounds.minY),
                           tangent2End: CGPoint(x: bounds.midX, y: bounds.minY),
                           radius: cornerRadius)
            
            pathRef.addArc(tangent1End: CGPoint(x: bounds.maxX, y: bounds.minY),
                           tangent2End: CGPoint(x: bounds.maxX, y: bounds.midY),
                           radius: cornerRadius)
            pathRef.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
            addLine = true
        } else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            pathRef.move(to: CGPoint(x: bounds.minX, y: bounds.minY))
            pathRef.addArc(tangent1End: CGPoint(x: bounds.minX, y: bounds.maxY),
                           tangent2End: CGPoint(x: bounds.midX, y: bounds.maxY),
                           radius: cornerRadius)
            
            pathRef.addArc(tangent1End: CGPoint(x: bounds.maxX, y: bounds.maxY),
                           tangent2End: CGPoint(x: bounds.maxX, y: bounds.midY),
                           radius: cornerRadius)
            pathRef.addLine(to: CGPoint(x: bounds.maxX, y: bounds.minY))
        } else {
            pathRef.addRect(bounds)
            addLine = true
        }
        
        layer.path = pathRef
        layer.strokeColor = UIColor.lightGray.cgColor
        layer.lineWidth = 0.5
        layer.fillColor = UIColor.white.cgColor
        
        if addLine == true {
            let lineLayer: CALayer = CALayer()
            let lineHeight: CGFloat = (1 / UIScreen.main.scale)
            lineLayer.frame = CGRect(x: bounds.minX, y: bounds.size.height - lineHeight, width: bounds.size.width, height: lineHeight)
            lineLayer.backgroundColor = UIColor.clear.cgColor
            layer.addSublayer(lineLayer)
        }
        
        let backgroundView: UIView = UIView(frame: bounds)
        backgroundView.layer.insertSublayer(layer, at: 0)
        backgroundView.backgroundColor = .white
        cell.backgroundView = backgroundView
    }
    
    var topbarHeight: CGFloat {
            return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
                (self.navigationController?.navigationBar.frame.height ?? 0.0)
        }
    
    func showTextInputPrompt(withMessage message: String,
                               completionBlock: @escaping ((Bool, String?) -> Void)) {
        let prompt = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
          completionBlock(false, nil)
        }
        weak var weakPrompt = prompt
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
          guard let text = weakPrompt?.textFields?.first?.text else { return }
          completionBlock(true, text)
        }
        prompt.addTextField(configurationHandler: nil)
        prompt.addAction(cancelAction)
        prompt.addAction(okAction)
        present(prompt, animated: true, completion: nil)
      }
    
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
    //    self.navigationItem.titleView = getHeaderLabel(title: name)
        self.tabBarController?.navigationItem.titleView = getHeaderLabel(title: name)
    }
    
    func setupNavBars(name : String){
        self.navigationItem.titleView = getHeaderLabel(title: name)
        //self.tabBarController?.navigationItem.titleView = getHeaderLabel(title: name)
    }
    
    func getHeaderLabel(title:String) -> UILabel{
        let w = title.width(forHeight: 18, font: UIFont(name: "Urbanist-Bold", size: 18)!)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: w, height: 18))
        label.text = title
        label.font = UIFont(name: "Urbanist-Bold", size: 18)
        label.textColor = .white
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
