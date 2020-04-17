//
//  ImageCacher.swift
//  Caturday
//
//  Created by Юрий Логинов on 17.04.2020.
//  Copyright © 2020 Юрий Логинов. All rights reserved.
//

import UIKit

class ImageCacher {
    static let shared = ImageCacher()
        
    private lazy var imageCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.countLimit = 500
        return cache
    }()
    
    func cacheImage(_ image: UIImage, for key: URL) {
        self.imageCache.setObject(image, forKey: key as AnyObject)
    }
    
    func getImage(for key: URL) -> UIImage? {
        return imageCache.object(forKey: key as AnyObject) as? UIImage
    }
}
