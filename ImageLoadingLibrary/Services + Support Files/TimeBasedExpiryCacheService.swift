//
//  CacheService.swift
//  ImageLoadingLibrary
//
//  Created by Mewan Chathuranga on 15/06/2018.
//  Copyright © 2018 Mewan Chathuranga. All rights reserved.
//

import Foundation
import UIKit

class TimeBasedCacheService{
    var cache = NSCache<NSString, AnyObject>()
    
    private var expiryTimeLengthInSeconds: Int? = nil
    
    func setCacheSize(_expiryTimeLengthInSeconds: Int){
             cache.countLimit = _expiryTimeLengthInSeconds
    }
    
    func clearCache(){
        cache.removeAllObjects()
        print("Cache Cleared!")
    }
    
    func cacheTimer(timeInterval: Double){
        let timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { (timer) in
            
            self.clearCache()
            
        }
    }
}
