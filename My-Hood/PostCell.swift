//
//  PostCell.swift
//  My-Hood
//
//  Created by Roman Mishiev on 03.02.16.
//  Copyright © 2016 Roman Mishiev. All rights reserved.
//

import UIKit
import Foundation

class PostCell: UITableViewCell {

    
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    
    var asd = NSDate.timeIntervalSinceReferenceDate()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        postImg.layer.cornerRadius = postImg.frame.width/2
        postImg.layer.cornerRadius = postImg.frame.height/2
        postImg.clipsToBounds = true
        
     
        dateLbl.text = "Date \(asd)"
    }
    
    // Настраиваем клетку
    func configureCell(post: Post) ->String {
        titleLbl.text = post.title
        descLbl.text = post.postDesc
        dateLbl.text = post.date
        
        // Задаем путь для изображения
        postImg.image = DataService.instance.imageForPath(post.imagePath)
        
        return description
    }

   
}
