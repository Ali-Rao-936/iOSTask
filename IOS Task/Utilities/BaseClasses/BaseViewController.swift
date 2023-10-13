

import UIKit
//import SideMenu

class BaseViewController: UIViewController { 
    var activityIndicator = ActivityIndicator()

    override func viewDidLoad() {
        super.viewDidLoad()
        //setNavBarColor()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
       return .lightContent
    }
    
    
    func setNavigationTitleWithText(text:String = "Database".localized) {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = text
    }
    func setTitleMargin()
    {
        let style = NSMutableParagraphStyle()
        style.firstLineHeadIndent = 5
        navigationController?.navigationBar.standardAppearance.largeTitleTextAttributes = [NSAttributedString.Key.paragraphStyle : style]
    }
    
    func setNavBarColor(color:UIColor = .white)
    {
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.removeBottomLine()
        let yourBackImage = UIImage(named: "back")
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.setBackIndicatorImage(yourBackImage, transitionMaskImage: yourBackImage)
        navBarAppearance.shadowImage = UIImage()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = color
        navBarAppearance.shadowColor = .clear
        self.navigationController?.navigationBar.backgroundColor = color
        self.navigationController?.navigationBar.tintColor = color
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
       
    }
    
    func makeTransparentBar(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()

        UINavigationBar.appearance().standardAppearance = appearance
        
    }
    
   
    
    func setTitle(title:String){
        self.navigationItem.titleView = getHeaderLabel(title: title)
    }
    
    func getHeaderLabel(title:String,color:UIColor = Colors.greenColor()) -> UILabel{
        let w = title.width(forHeight: 20, font: UIFont(name: "Kanit-SemiBold", size: 20)!)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: w, height: 20))
        label.text = title
        label.font = UIFont(name: "Kanit-SemiBold", size: 20)
        label.textColor = color
        return label
    }
    

    
    func setCustomNavBarColor(color:UIColor){
        self.navigationController?.navigationBar.backgroundColor = color
        self.navigationController?.navigationBar.barTintColor = color
    }
    
    func makeNavTransparent(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.isTranslucent = true
    }
    
        

    
}
