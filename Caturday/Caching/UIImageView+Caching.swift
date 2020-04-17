//
//  UIImageView+Caching.swift
//  Caturday
//
//  Created by Юрий Логинов on 17.04.2020.
//  Copyright © 2020 Юрий Логинов. All rights reserved.
//

import UIKit

private var AssociatedObjectHandle: UInt8 = 0
private let LoaderTag = 777667

extension UIImageView {
    private var currentURL: URL {
        get {
            return objc_getAssociatedObject(self, &AssociatedObjectHandle) as! URL
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func downloaded(from url: URL) {
        currentURL = url
        
        showLoader()
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.hideLoader()
            }
            
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                if url == self.currentURL {
                    ImageCacher.shared.cacheImage(image, for: url)
                    self.image = image
                }   
            }
        }.resume()
    }
}

extension UIImageView {
    func showLoader() {
        if let hud = self.viewWithTag(LoaderTag) as? UIActivityIndicatorView {
            hud.startAnimating()
            return
        } else {
            let hud = UIActivityIndicatorView(style: .gray)
            hud.tag = LoaderTag
            hud.hidesWhenStopped = true
            addSubview(hud)
            hud.centerToSuperview()
            bringSubviewToFront(hud)
            hud.startAnimating()
        }
    }

    func hideLoader() {
        if let hud = self.viewWithTag(LoaderTag) as? UIActivityIndicatorView {
            hud.stopAnimating()
            return
        }
    }
}

