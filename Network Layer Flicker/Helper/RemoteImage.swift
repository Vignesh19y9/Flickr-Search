//
//  RemoteImage.swift
//  Network Layer Flicker
//
//  Created by Martijn Van der Spek on 29/03/22.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView{
    func loadImageFromUrl(urlString: String, placeholder: UIImage? = nil) -> URLSessionDataTask?{
        //making current imae nil
        self.image = nil
        
        //image has been chached
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)){
            self.image = cachedImage
            return nil
        }
        
        //invalid url
        guard let url = URL(string: urlString) else{
            return nil
        }
        //setting default image
        if let placeHolder = placeholder{
            self.image = placeholder
        }
        
        let task = URLSession.shared.dataTask(with: url){ data,_ ,_ in
            DispatchQueue.main.async {
                if let data = data, let downloadedImage = UIImage(data: data){
                    imageCache.setObject(downloadedImage, forKey: NSString(string: urlString))
                    self.image = downloadedImage
                }
            }
        }
        task.resume()
        return task
    }
}
