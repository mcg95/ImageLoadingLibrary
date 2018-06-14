//
//  ImageeLoadService.swift
//  ImageLoadingLibrary
//
//  Created by Mewan Chathuranga on 14/06/2018.
//  Copyright © 2018 Mewan Chathuranga. All rights reserved.
//

import Foundation
import UIKit

class ImageLoadService: FileDownloaderProtocol{
    
    internal var StatusMessage: String = ""
    let imageCache = TimeBasedCacheService()
    
    
    func downloadImage(withURL url: URL, completion: @escaping (UIImage?) -> ()) {
        DispatchQueue.main.async {
            let downloadTask = URLSession.shared.dataTask(with: url) { (data, responseURL, err) in
                var downloadedImage:UIImage?
                
                if let data = data{
                    downloadedImage = UIImage(data: data)
                }
                if downloadedImage != nil{
                    self.imageCache.cache.setObject(downloadedImage!, forKey: url.absoluteString as NSString)
                }
            }
            downloadTask.resume()
        }
    }
    
    func getImage(withURL url: URL, completion: @escaping (UIImage?) -> ()) {
        DispatchQueue.main.async {
            if let image = self.imageCache.cache.object(forKey: url.absoluteString as NSString){
                
                self.StatusMessage = "0"
                
            }else{
                self.downloadImage(withURL: url, completion: completion)
                self.StatusMessage = "1"
            }
        }
    }
    
    func returnLoadedFrom() -> (String) {
        var loadedLocation = ""
        let statusMessage = StatusMessage
        if statusMessage == "1"{
            loadedLocation = "Image Loaded from Web!"
        }else if statusMessage == "0"{
            loadedLocation = "Image Loaded from Cache!"
        }
        return loadedLocation
    }
    
    
}
