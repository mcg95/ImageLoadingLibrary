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
        
    func downloadImage(withURL url:URL, completion: @escaping (_ image:UIImage?)->())
    func getImage(withURL url:URL, completion: @escaping (_ image:UIImage?)->())
   
}
