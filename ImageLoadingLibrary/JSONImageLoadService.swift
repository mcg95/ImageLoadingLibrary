//
//  JSONImageLoadService.swift
//  ImageLoadingLibrary
//
//  Created by Mewan Chathuranga on 13/06/2018.
//  Copyright © 2018 Mewan Chathuranga. All rights reserved.
//

import Foundation
import UIKit


class JSONImageLoadService {
    
    static let cache = NSCache<NSString, UIImage>()
    
    var LoadedLocation = ""
    var StatusMessage = ""
    var jsonObj: [jsonRoot]? = nil

    func getJsonObj() -> [jsonRoot]{
      
        return jsonObj!
    }
    
    func setCacheSize(noOfObj: Int){
        JSONImageLoadService.cache.countLimit = noOfObj
    }
    
    func fetchJSON(jsonURL: String){

        guard let url = URL(string: jsonURL) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                return
            }
            
            do{
                let decoder = JSONDecoder()
                //  decoder.keyDecodingStrategy = .convertFromSnakeCase
                let json = try decoder.decode([jsonRoot].self, from: data)
                self.jsonObj = json
                
            }
            catch{
                print(error)
            }
            
            
            }.resume()
        
    }
    
    func downloadImage(withURL url:URL, completion: @escaping (_ image:UIImage?)->()){
        let downloadTask = URLSession.shared.dataTask(with: url) { (data, responseURL, err) in
            var downloadedImage:UIImage?
            
            if let data = data{
                downloadedImage = UIImage(data: data)
                
                
            }
            if downloadedImage != nil{
                JSONImageLoadService.cache.setObject(downloadedImage!, forKey: url.absoluteString as NSString)
            }
            
            DispatchQueue.main.async {
                // completion(downloadedImage)
            }
        }
        downloadTask.resume()
    }
    
    
    func getImage(withURL url:URL, completion: @escaping (_ image:UIImage?)->()){
        if let image = JSONImageLoadService.cache.object(forKey: url.absoluteString as NSString){
            DispatchQueue.main.async {
                self.StatusMessage = "0"
            }
            completion(image)
            
        }else{
            downloadImage(withURL: url, completion: completion)
            DispatchQueue.main.async {
                self.StatusMessage = "1"
            }
        }
    }
    
    
    func returnLoadedFrom() -> (String){
        var loadedLocation = ""
        let statusMessage = StatusMessage
        if statusMessage == "1"{
            
            loadedLocation = "Image Loaded from Web!"
            
        }else if statusMessage == "0"{
            loadedLocation = "Image Loaded from Cache!"
            
        }
        return loadedLocation
    }
    
    func clearCache(){
        JSONImageLoadService.cache.removeAllObjects()
        print("Cache Cleared!")
    }
    
    func cacheTimer(timeInterval: Double){
        let timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { (timer) in
            
            self.clearCache()
            
        }
    }

}


