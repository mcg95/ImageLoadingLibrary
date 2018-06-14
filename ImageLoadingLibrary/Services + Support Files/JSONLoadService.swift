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
    
   
    
    func fetchDocument(docURL: String) -> [documentRoot] {
        
        guard let url = URL(string: docURL) else {
            print("fetchDocu - URL not found")
            return documentObj
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
        return documentObj
    }
    
    func getDocumentObj() -> [documentRoot] {
        return documentObj
    }
    
    
    
}
