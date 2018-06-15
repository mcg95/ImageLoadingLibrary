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
    //While this function is only for downloading images, Generics in Swift can be used to define a method that will be able to download any type of data but the data manipulation must be done by the user.
    //retrieves image from the web
    func downloadImage(withURL url:URL, completion: @escaping (_ image:UIImage?)->())
    
    //checks if image is available in cache to retrieve, else will call downloadImage function again.
    func getImage(withURL url:URL, completion: @escaping (_ image:UIImage?)->())
   
}
