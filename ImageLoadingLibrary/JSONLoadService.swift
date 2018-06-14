//
//  JSONLoadService.swift
//  ImageLoadingLibrary
//
//  Created by Mewan Chathuranga on 14/06/2018.
//  Copyright © 2018 Mewan Chathuranga. All rights reserved.
//

import Foundation
import UIKit

class JSONLoadService: DocumentLoaderProtocol{
    
    
    var documentObj: [documentRoot] = []
    var LoadedLocation: String = ""
    
    static var cache: NSCache<NSString, UIImage>{
        get{
            return NSCache<NSString, UIImage>()
        }
    }
    
    func fetchDocument(docURL: String) {
        guard let url = URL(string: docURL) else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }
            do{
                let decoder = JSONDecoder()
                //  decoder.keyDecodingStrategy = .convertFromSnakeCase
                let json = try decoder.decode([documentRoot].self, from: data)
                self.documentObj = json
            }
            catch{
                print(error)
            }
            }.resume()
    }
    
    func getDocumentObj() -> [documentRoot] {
        return documentObj
    }
    
    func clearCache() {
        JSONLoadService.cache.removeAllObjects()
        print("Cache Cleared!")
    }
    
    func cacheTimer(timeInterval: Double) {
        let timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { (timer) in
            
            self.clearCache()
            
        }
    }
    
}
