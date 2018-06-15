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
    
    //While this function is only for retrieving JSON data, Generics in Swift can be used to define a method that will be able to download any type of data but the data manipulation must be done by the user.
    func fetchDocument(docURL: String)
   
    
}
