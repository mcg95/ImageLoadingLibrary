//
//  JSONImageLoadService.swift
//  ImageLoadingLibrary
//
//  Created by Mewan Chathuranga on 13/06/2018.
//  Copyright © 2018 Mewan Chathuranga. All rights reserved.
//

import Foundation
import UIKit

//Change current class name to ImageLoadService
//add interface to help support more file types (file download - image and pdf, document loading - json)
//
class ImageLoadService {
    
    static let cache = NSCache<NSString, UIImage>()
    
    var LoadedLocation = ""
    var StatusMessage = ""
    var jsonObj: [jsonRoot] = []

    func getJsonObj() -> [jsonRoot]{
      
        return jsonObj
    }
    
    func setCacheSize(noOfObj: Int){
  //      JSONImageLoadService.cache.countLimit = noOfObj
    }
    
    func fetchJSON(jsonURL: String){
        //move to new class.
        guard let url = URL(string: jsonURL) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                return
            }
       //     DispatchQueue.global(qos: .userInitiated).async {
            do{
                let decoder = JSONDecoder()
                //  decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                    let json = try decoder.decode([jsonRoot].self, from: data)
                    self.jsonObj = json
                
               
                
                
            }
            catch{
                print(error)
            }
            
    //        }
            }.resume()
        
        
    }
    
    func downloadImage(withURL url:URL, completion: @escaping (_ image:UIImage?)->()){
        DispatchQueue.main.async {
        
        let downloadTask = URLSession.shared.dataTask(with: url) { (data, responseURL, err) in
            var downloadedImage:UIImage?
            
            if let data = data{
                downloadedImage = UIImage(data: data)
                
                
            }
            if downloadedImage != nil{
                ImageLoadService.cache.setObject(downloadedImage!, forKey: url.absoluteString as NSString)
            }
            
           
        }
        downloadTask.resume()
        }
    }
    
    func getImage(withURL url:URL, completion: @escaping (_ image:UIImage?)->()){
         DispatchQueue.main.async {
        if let image = ImageLoadService.cache.object(forKey: url.absoluteString as NSString){
           
                self.StatusMessage = "0"
            
            completion(image)
            
        }else{
            self.downloadImage(withURL: url, completion: completion)
            
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
        ImageLoadService.cache.removeAllObjects()
        print("Cache Cleared!")
    }
    
    func cacheTimer(timeInterval: Double){
        let timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { (timer) in
            
            self.clearCache()
            
        }
    }


}


