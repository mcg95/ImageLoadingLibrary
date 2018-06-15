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
    
    //print statements are used for informing developers what is the reason for any crash that occurs and debugging purposes
    
    let imageCache = CacheService()
    
    
    func downloadImage(withURL url: URL, completion: @escaping (UIImage?) -> ()) {
          DispatchQueue.global(qos: .background).async {
            let downloadTask = URLSession.shared.dataTask(with: url) { (data, responseURL, err) in
                var downloadedImage:UIImage?
                if err != nil{
                    print("Error: ", err?.localizedDescription)
                }else{
                if let data = data{
                    downloadedImage = UIImage(data: data)
                    completion(downloadedImage)

                }
                if downloadedImage != nil{
                    self.imageCache.cache.setObject(downloadedImage!, forKey: url.absoluteString as NSString)
                    completion(downloadedImage)
                }
            }
        }
            downloadTask.resume()
        }
    }
    
    func getImage(withURL url: URL, completion: @escaping (UIImage?) -> ()) {
            if let image = self.imageCache.cache.object(forKey: url.absoluteString as NSString){
                print("Loaded from Cache")
                
            }else{
                self.downloadImage(withURL: url, completion: completion)
                print("Downloaded from Internet")

            }
        
    }
    
}
