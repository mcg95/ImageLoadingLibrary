//
//  ViewController.swift
//  ImageLoadingLibrary
//
//  Created by Mewan Chathuranga on 12/06/2018.
//  Copyright © 2018 Mewan Chathuranga. All rights reserved.
//

import UIKit
/*
struct ImageKit: Decodable{
    let urls: userImageURLS
    let user: userDetails
  
}

struct userImageURLS:Decodable{
    
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
    
}
struct userDetails: Decodable{
    let profile_image: profileImage

        
}
struct profileImage: Decodable{
    let small: String
    let medium: String
    let large: String
    
}
*/
class ViewController: UIViewController {

    @IBOutlet weak var testImageView: UIImageView!
    static let cache = NSCache<NSString, UIImage>()
    let JSONImageService = JSONImageLoadService()

    @IBOutlet weak var testLbl: UILabel!
    
    @IBAction func refreshBtn(_ sender: Any) {
        JSONImageService.fetchJSON(jsonURL: "https://pastebin.com/raw/wgkJgazE")
        print("Refreshed!!!")
        testLbl.text = JSONImageService.returnLoadedFrom()
        loadImagetoView()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    func loadImagetoView(){
        let json = JSONImageService.getJsonObj()
        for imageURL in json{
            JSONImageService.getImage(withURL: URL(string: imageURL.user.profile_image.large)!, completion: { (image) in
                
                self.testImageView.image = image
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }

   
    
}

