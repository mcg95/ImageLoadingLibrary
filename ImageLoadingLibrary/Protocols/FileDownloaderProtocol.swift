//
//  FileDownloaderProtocol.swift
//  ImageLoadingLibrary
//
//  Created by Mewan Chathuranga on 14/06/2018.
//  Copyright © 2018 Mewan Chathuranga. All rights reserved.
//

import Foundation
import UIKit

protocol FileDownloaderProtocol{
    //retrieves image from the web
    func downloadImage(withURL url:URL, completion: @escaping (_ image:UIImage?)->())
    
    //checks if image is available in cache to retrieve, else will call downloadImage function again.
    func getImage(withURL url:URL, completion: @escaping (_ image:UIImage?)->())
   
}
