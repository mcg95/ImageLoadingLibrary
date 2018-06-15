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
    
    //fetches data from any provided URL. Currently only decodes Json. 
    func fetchDocument(docURL: String)
    
}
