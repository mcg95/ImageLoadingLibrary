//
//  ViewController.swift
//  ImageLoadingLibrary
//
//  Created by Mewan Chathuranga on 12/06/2018.
//  Copyright © 2018 Mewan Chathuranga. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    static let cache = NSCache<NSString, UIImage>()
    let JSONImageService = JSONImageLoadService()

    
    @IBAction func removeImageBtn(_ sender: Any) {
        testImageView.image = nil
        testLbl.text = ""
    }
    
    @IBOutlet weak var testImageView: UIImageView!
   
    @IBOutlet weak var testLbl: UILabel!
    
    @IBAction func refreshBtn(_ sender: Any) {
        testLbl.text = JSONImageService.returnLoadedFrom()
        loadImagetoView()
        print("Refreshed!!!")

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        JSONImageService.fetchJSON(jsonURL: "https://pastebin.com/raw/wgkJgazE")

        
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

