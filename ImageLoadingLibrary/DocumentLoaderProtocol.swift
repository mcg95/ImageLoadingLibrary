//
//  DataDownloadProtocol.swift
//  ImageLoadingLibrary
//
//  Created by Mewan Chathuranga on 14/06/2018.
//  Copyright © 2018 Mewan Chathuranga. All rights reserved.
//

import Foundation
import UIKit

protocol DocumentLoaderProtocol{
    var documentObj: [documentRoot] {get}
    static var cache: NSCache<NSString, UIImage> {get}
    var LoadedLocation: String {get}
    
    func fetchDocument(docURL: String)
    func getDocumentObj() -> [documentRoot]
    func clearCache()
    func cacheTimer(timeInterval: Double)
    
}
