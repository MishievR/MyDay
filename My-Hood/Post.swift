//
//  Post.swift
//  My-Hood
//
//  Created by Roman Mishiev on 02.02.16.
//  Copyright © 2016 Roman Mishiev. All rights reserved.
//

import Foundation
import UIKit

// Если нужно архивировать и разархивировать data всегда нужно указывать NSObject, NSCoding в type информации (data'ы)
class Post: NSObject, NSCoding {
    
    // Data incapsulation для безопасного кода
    private var _imagePath: String!
    private var _title: String!
    private var _postDesc: String!
    private var _date: String!
    
    var date: String {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .MediumStyle
        dateFormatter.stringFromDate(NSDate())
        
        return dateFormatter.stringFromDate(NSDate())
        
    }
    var imagePath: String {
        return _imagePath
    }
    
    var title: String {
        return _title
    }
    
    var postDesc: String {
        return _postDesc
    }
    
    
    
    init(imagePath: String, title: String, description: String, date: String) {
        self._imagePath = imagePath
        self._title = title
        self._postDesc = description
        self._date = date
        
        
    }
    // Стандартный INIT()
    // Initialize yoursef, when you decoding something!
    override init() {
        
    }
    // Если LOAD то вызывается эта функция (декодирует)
    required convenience init?(coder aDecoder: NSCoder) {
        // Вызываем инициалайзер
        self.init()
        // Говорим как декодировать.
        // Берем _imagePath (это то, что мы загружаем) далее мы говорим: когда кто-то тебя разархивирует ты должен декодироваться в "imagePath"
        self._imagePath = aDecoder.decodeObjectForKey("imagePath") as? String
        self._title = aDecoder.decodeObjectForKey("title") as? String
        self._postDesc = aDecoder.decodeObjectForKey("description") as? String
        self._date = aDecoder.decodeObjectForKey("date") as? String
        
    }
    
    // Если SAVE то эта (закодирует)
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self._imagePath, forKey: "imagePath")
        aCoder.encodeObject(self._title, forKey: "title")
        aCoder.encodeObject(self._postDesc, forKey: "description")
        aCoder.encodeObject(self._date, forKey: "date")
    }
    
}







