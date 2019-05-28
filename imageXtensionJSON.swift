//
//  imageXtensionJSON.swift
//
//  Created by Izloop on 5/17/19.
//  Copyright © 2019 Peter Levi Hornig. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

//MARK: - Image Cache

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func loadImageUsingCacheWithUrlString(_ urlString: String) {
        
        self.image = nil
        
        //check for image first
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        
        //otherwise fire off a new download
        Alamofire.request(urlString)
            .responseImage { response in
                
                if let downloadedImage = response.result.value {
                    //image is here
                    imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                    self.image = downloadedImage
                }
        }
    }
}
