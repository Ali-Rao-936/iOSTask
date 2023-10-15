//
//  DetailsViewController.swift
//  IOS Task
//
//  Created by Ali on 13/10/2023.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet var titleLable: UILabel!
    @IBOutlet var authorNameLable: UILabel!
    @IBOutlet var timeLable: UILabel!
    @IBOutlet var descriptionLable: UILabel!
    @IBOutlet var nameLable: UILabel!
    @IBOutlet var imgNews: UIImageView!
    
    var article : Articles?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setBackButton()
        
        setDetails()
    }
    

    func setDetails(){
        self.imgNews.setImage(with: article?.urlToImage, placeholder: Utility.getPlaceHolder())
        setupNavBar(name: article?.source?.name ?? "News Details")
        self.authorNameLable.text = article?.author
        self.titleLable.text = article?.title
        self.descriptionLable.text = article?.description
        self.timeLable.text = Utility.timeInMins(date: article?.publishedAt ?? "")
        
    }

}
