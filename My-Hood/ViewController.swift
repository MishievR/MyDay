//
//  ViewController.swift
//  My-Hood
//
//  Created by Roman Mishiev on 02.02.16.
//  Copyright © 2016 Roman Mishiev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Говорим что и delegate и datasource содержатся в tableView
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Загружаем сохраненные посты
        DataService.instance.loadPosts()
        
        // addObserver - это добавить наблюдатель, который смотрит чтобы при появлении уведомления "postsLoaded" вызвать функцию  "onPostsLoaded:". 
        //Observer это какой класс, мы говорим self; selector: то какую функцию хотим вызвать, обязательно "abc:" так как мы говорим что это параметр; name: должно быть точно такое же как в addPostNS
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onPostsLoaded:", name: "postsLoaded", object: nil)
        
        /*
        Здесть можно вставить 
        tableView.estimatedRowHeight = 86 (86 - высота rowSection)
        для создания вариабельной высоты лейбла.
        */
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // Эта функция означает: что каждый раз когда мы хотим убрать новую информацию, убирать ее в cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Создаем конкретную информацию с конкретным намером из Array постов, в конкретной клетке (Старая)
        // let post = posts[indexPath.row]
        
        // Показываем откуда брать информацию
        let post = DataService.instance.loadedPosts[indexPath.row]
        
        // Делаем секции reuseble для экономии места.
        // dequeueReusableCellWithIdentifier возьми секцию
        if let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as? PostCell {
            cell.configureCell(post)
            return cell
        } else
            // Если tableView не дает клетку, то мы сами создаем новую
            {
            // Если не работает выше, то говорми, сделай самую стандартную новую клетку
            let cell = PostCell()
            
            cell.configureCell(post)
            return cell
        }
    }
    // Высота секции с информацией (см выше как сделать плавующей)
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        // Задаем высоту 86
        return 100.0
    }

    // Сколько нужно секций с информацией
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // 15 строчка. Сначала создаем пустую информацию (пост) для секции. Функции говорим - сколько (Постов) информации, столько и секций.
        return DataService.instance.loadedPosts.count
    }
    
    // Создаем функцию для addObserver. Задаем один параметр notif: и это может быть любой параметр
    
    // Функция обновляет инормацию для сохранения
    func onPostsLoaded(notif: AnyObject) {
        tableView.reloadData()
    }
    
    /* Эта функция нужна когда при нажатии на секцию мы вызываем какое-нибудь view или data
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {

    }
    */
 
  


}

