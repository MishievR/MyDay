//
//  DataService.swift
//  My-Hood
//
//  Created by Roman Mishiev on 03.02.16.
//  Copyright © 2016 Roman Mishiev. All rights reserved.
//

import Foundation
import UIKit

class DataService {
    
    // не знаю что это.
    static let instance = DataService()
    
    let KEY_POSTS = "posts"
    
    private var _loadedPosts = [Post]()
    
    var loadedPosts: [Post] {
        return _loadedPosts
    }
    
    // Создаем набор функций для работы
    
    // Сохранить посты
    func savePosts() {
        // Переводим array в Биты для архивации (архиватор c ключом)
        let postsData = NSKeyedArchiver.archivedDataWithRootObject(_loadedPosts)
        
        // Сохраняем через стандартный механизм наш Array в виде Битов и даем ключ 19
        NSUserDefaults.standardUserDefaults().setObject(postsData, forKey: KEY_POSTS)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    
    // Загрузить посты
    func loadPosts() {
        // Загрузить объект (в виде архивированных битов) по ключу KEY_POSTS (19)
        if let postsData = NSUserDefaults.standardUserDefaults().objectForKey(KEY_POSTS) as? NSData {
            
            // Разархивируем объекты с data как array постов, !!! но он не знает как это сделать, поэтому в файле Post.swift мы ему это скажем
            if let postsArray = NSKeyedUnarchiver.unarchiveObjectWithData(postsData) as? [Post] {
                // Если все работает, загрузить посты
                _loadedPosts = postsArray
            }
        }
        
        // Здесь для проверки мы говорим чтобы NSNotificationCenter.defaultCenter() сделал postNotification, а он в свою очередь создал новое уведомление NSNotification и дал ему имя name: "postsLoaded"
        // Это включается только при вызове функции загрузки.
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "postsLoaded", object: nil))
        
    }
    
    // Сохранить изображение и сделать путь его места
    func saveImageAndCreatePath(image: UIImage) ->String {
        
        // Конвертируем в PNG формат
        let imgData = UIImagePNGRepresentation(image)
        
        // Даем файлу уникальное название по дате и времени
        let imgPath = "image\(NSDate.timeIntervalSinceReferenceDate()).png"
        
        // Присылаем функции documentsPathForFileName название файла, чтобы она его добавила в конец пути
        let fullPaht = documentsPathForFileName(imgPath)
        
        // Записываем в битах информацию по указанному пути
        imgData?.writeToFile(fullPaht, atomically: true)
        
        return imgPath
    }
    
    // Загрузить изображение по его пути
    func imageForPath(path: String) -> UIImage? {
        
        let fullPath = documentsPathForFileName(path)
        
        let image = UIImage(named: fullPath)
        
        return image
        
    }
    
    // Добавить пост
    func addPost(post: Post) {
        
        // Добавляем посты в Array
        _loadedPosts.append(post)
        
        // Сохраняем все посты
        savePosts()
        
        // Загружаем
        loadPosts()
    }
    
    // Функция для создания и поиска пути файла фотографии "photo.jpg"
    func documentsPathForFileName(name: String) ->String {
        
        //NSSearchPathForDirectoriesInDomains дает пути в .DocumentDirectory для .UserDomainMask, то есть показывает пути нахождения файлов (user/documents/photo/)
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        
        // Добавляем Array
        let fullPath = paths[0] as NSString
        // Присоединяем название файла в конец пути user/documents/photo/PHOTO.JPG
        return fullPath.stringByAppendingPathComponent(name)
    }
    
    
    
}