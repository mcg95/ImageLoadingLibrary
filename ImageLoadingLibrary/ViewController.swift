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
    let user: userDetails
  
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
struct userDetails: Decodable{
    let profile_image: profileImage

        
}
struct profileImage: Decodable{
    let small: String
    let medium: String
    let large: String
    
}

class ViewController: UIViewController {

    static let cache = NSCache<NSString, UIImage>()

    @IBOutlet weak var testLbl: UILabel!
    
    @IBAction func refreshBtn(_ sender: Any) {
        fetchJSON()
        print("Refreshed!!!")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetchJSON()
       
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func fetchJSON(){
        let jsonURL = "https://pastebin.com/raw/wgkJgazE"
        
        guard let url = URL(string: jsonURL) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                return
            }
            
            do{
                let decoder = JSONDecoder()
              //  decoder.keyDecodingStrategy = .convertFromSnakeCase
                let json = try decoder.decode([ImageKit].self, from: data)
                for imageURL in json{
                    print("User Image: ", imageURL.urls.small)
                    print("Profile Image: ",imageURL.user.profile_image.medium)
                    self.getImage(withURL: URL(string: imageURL.urls.small)!, completion: { (image) in
                        print(image?.ciImage)
                    })
                }
            }
            catch{
                print(error)
            }
            
            
            }.resume()
        
    }
     func downloadImage(withURL url:URL, completion: @escaping (_ image:UIImage?)->()){
        let downloadTask = URLSession.shared.dataTask(with: url) { (data, responseURL, err) in
            var downloadedImage:UIImage?

            if let data = data{
                downloadedImage = UIImage(data: data)
                

            }
            if downloadedImage != nil{
 ViewController.cache.setObject(downloadedImage!, forKey: url.absoluteString as NSString)
            }
            
            DispatchQueue.main.async {
               // completion(downloadedImage)
            }
        }
        downloadTask.resume()
    }
    func getImage(withURL url:URL, completion: @escaping (_ image:UIImage?)->()){
        if let image = ViewController.cache.object(forKey: url.absoluteString as NSString){
            DispatchQueue.main.async {
                self.testLbl.text = "Image Loaded from Cache"
            }
            completion(image)

        }else{
            downloadImage(withURL: url, completion: completion)
            DispatchQueue.main.async {
                self.testLbl.text = "Image Loaded from Web"

            }
        }
    }
    
}

