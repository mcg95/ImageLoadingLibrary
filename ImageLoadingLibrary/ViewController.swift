//
//  ViewController.swift
//  ImageLoadingLibrary
//
//  Created by Mewan Chathuranga on 12/06/2018.
//  Copyright © 2018 Mewan Chathuranga. All rights reserved.
//

import UIKit

struct ImageKit: Decodable{
//    let profileImages: [profileImage]
    let urls: userImageURLS

  
}

struct userImageURLS:Decodable{
    
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
    
  /*  private enum CodingKeys: String, CodingKey{
        
        case rawURL = "raw"
        case fullURL = "full"
        case regularURL = "regular"
        case smallURL = "small"
        case thumbURL = "thumb"
    }*/
}
struct profileImage: Decodable{
    let profileImageSmlURL: String
    let profileImageMedURL: String
    let profileImageLrgURL: String
    
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let jsonURL = "https://pastebin.com/raw/wgkJgazE"
        
        guard let url = URL(string: jsonURL) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                return
            }
            
            do{
                let json = try JSONDecoder().decode([ImageKit].self, from: data)
                for imageURL in json{
                    print(imageURL.urls.small)
                }
            }
            catch{
                print(error)
            }
        
            
        }.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

