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

     //print statements are used for informing developers what is the reason for any crash that occurs and debugging purposes
    
    var documentObj: [documentRoot] = []
    
    func fetchDocument(docURL: String) {
        
        guard let url = URL(string: docURL) else {
            print("fetchDocu - URL not found")
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }
            if error != nil{
                print("Error: ", error?.localizedDescription)
            }else{
            DispatchQueue.global(qos: .userInitiated).async {

            do{
                let decoder = JSONDecoder()
                //convertFromSnakeCase must only be used if the JSONStructure variables are not named exactly as in the JSON.
                //  decoder.keyDecodingStrategy = .convertFromSnakeCase
                let json = try decoder.decode([documentRoot].self, from: data)
                self.documentObj = json
            }
            catch{
                print(error)
                }}
            }
            }.resume()
    }
    
    func getDocumentObj() -> [documentRoot] {
        //print("Count", documentObj.count)

        return documentObj
    }
    
    
    
}
