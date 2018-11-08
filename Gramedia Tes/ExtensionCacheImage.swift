//
//  Extension.swift
//  Gramedia Tes
//
//  Created by tashya on 11/8/18.
//  Copyright © 2018 FajriCorp. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func setupImage(urlString: String){
        let url = URL(string: urlString)
        image = nil
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error ?? "")
                return
            }
            
            DispatchQueue.main.async {
                if let imageToCache = UIImage(data: data!){
                    imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                    self.image = imageToCache
                } 
            }
        }.resume()
    }
}
