//
//  NewsItemTableViewCell.swift
//  IOS Task
//
//  Created by Qoo on 14/10/2023.
//

import UIKit

class NewsItemTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLable: UILabel!
    @IBOutlet var authorLable: UILabel!
    @IBOutlet var imgNews: UIImageView!
    @IBOutlet var titleLable: UILabel!
    @IBOutlet var timeLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(article : Articles?){
        self.nameLable.text = article?.source?.name
        self.authorLable.text = article?.author
        self.titleLable.text = article?.title
        self.timeLable.text = Utility.timeInMins(date: article?.publishedAt ?? "")
        self.imgNews.setImage(with: article?.urlToImage, placeholder: Utility.getPlaceHolder())
    }
    
}
