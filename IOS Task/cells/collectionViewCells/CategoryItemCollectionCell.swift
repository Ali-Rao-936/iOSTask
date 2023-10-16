//
//  CategoryItemCollectionCell.swift
//  IOS Task
//
//  Created by Ali on 14/10/2023.
//

import UIKit

class CategoryItemCollectionCell: UICollectionViewCell {

    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var imgCategory: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override var isSelected: Bool{
        didSet{
            if isSelected {
                lineView.backgroundColor = .black
                nameLable.textColor = .black
            }else{
                lineView.backgroundColor = .white
                nameLable.textColor = Colors.grayTextColor()

            }
        }
    }
    
}
