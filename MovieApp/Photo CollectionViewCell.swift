//
//  Photo CollectionViewCell.swift
//  MovieApp
//
//  Created by Sharon on 2021/11/5.
//

import UIKit

class Photo_CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var photo: Photo!
    let a = 1
    
    let imageCache = NSCache<NSURL, UIImage>()//<>裡的key,value都需要是物件，所以要用class定義的型別，URL是struct，改用NSURL
    
    func fetchImage(url: URL, completion: @escaping (UIImage?)-> Void){
        
        if let image = imageCache.object(forKey: url as NSURL){ //當cache有圖時，直接取cache裡的圖片
            completion(image)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data){
                self.imageCache.setObject(image, forKey: url as NSURL) //網路抓圖後，將圖片存進cache
                
                completion(image)
            }else{
                completion(nil)
            }
        }.resume()
    }
    
    func update(){
        let rgb = photo.rgb
        label.text = photo.rgb
        imageView.image = UIImage(systemName: "questionmark.circle")
        fetchImage(url: photo.url) { (image) in
            guard let image = image else {return}
            DispatchQueue.main.async {
                if rgb == self.photo.rgb{ //加入此判斷可避免cell顯示錯誤的圖
                self.imageView.image = image
                }
            }
        }
    }
    
    
}
