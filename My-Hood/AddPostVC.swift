//
//  AddPostVC.swift
//  My-Hood
//
//  Created by Roman Mishiev on 03.02.16.
//  Copyright © 2016 Roman Mishiev. All rights reserved.
//

import UIKit

class AddPostVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var titleField: UITextField!

    @IBOutlet weak var postImg: UIImageView!
    
    @IBOutlet weak var descField: UITextField!
    
    @IBOutlet weak var dateLbl: UILabel!
    // Выбор изображения
    var imagePicker: UIImagePickerController!
    
    
  
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        postImg.layer.cornerRadius = postImg.frame.height/2
        postImg.layer.cornerRadius = postImg.frame.width/2
        postImg.clipsToBounds = true
        
        // Делаем INIT()
        imagePicker = UIImagePickerController()
        
        // Говорим что он для обратной фунции
        imagePicker.delegate = self
   
    }

    
    @IBAction func makePostBtnPressed(sender: UIButton!) {
        
        // Проверяем чтобы все было заполнено
        if let title = titleField.text, let desc = descField.text, let img = postImg.image, let dat = dateLbl.text {
            
            let imgPath = DataService.instance.saveImageAndCreatePath(img)
            
            // Создаем тестовый пост
            let post = Post(imagePath: imgPath, title: title, description: desc, date: dat)
            
            // Обращаемся к файлу DataService чтобы добаить пост в array (и произвести все остаьные действия: сохранить и перезагрузить)
            DataService.instance.addPost(post)
            
            // Спрятать окно после нажатия
            dismissViewControllerAnimated(true, completion: nil)
        }
        
    }
    @IBAction func cancelBtnPressed(sender: AnyObject) {
        
        // Возвращаемся на предыдущую страницу
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    @IBAction func addPhotoBtnPressed(sender: AnyObject) {
        
        // Функция чтобы убрать текст с кнопки (в данном случае при нажатии)
        sender.setTitle("", forState: .Normal)
        // Показываем выбор изображения на данном VC
        presentViewController(imagePicker, animated: true, completion: nil)

    }
    
    // Функция чтобы убрать Меню выбора изображения
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        // Убираем
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        postImg.image = image
        
    }
   
   


}
