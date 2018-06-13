//
//  ViewController.swift
//  ImageLoadingLibrary
//
//  Created by Mewan Chathuranga on 12/06/2018.
//  Copyright © 2018 Mewan Chathuranga. All rights reserved.
//

import UIKit
class ViewController: UIViewController {

    @IBOutlet weak var imageCollectionView: UICollectionView!
    static let cache = NSCache<NSString, UIImage>()
    let JSONImageService = JSONImageLoadService()
    var imageURLs: [String] = []
    
    @IBAction func removeImageBtn(_ sender: Any) {
        testImageView.image = nil
        testLbl.text = ""
    }
    
    @IBOutlet weak var testImageView: UIImageView!
   
    @IBOutlet weak var testLbl: UILabel!
    
    @IBAction func refreshBtn(_ sender: Any) {
        let json = JSONImageService.getJsonObj()
        for imageURL in json{
                self.imageURLs.append(imageURL.urls.regular)
                
            
        }
        imageCollectionView.reloadData()

        //loadImagetoView()
        print("Refreshed!!!")

    }
    
    override func viewDidAppear(_ animated: Bool) {
        let json = JSONImageService.getJsonObj()
        for imageURL in json{
            self.imageURLs.append(imageURL.urls.regular)

        }
        self.JSONImageService.fetchJSON(jsonURL: "https://pastebin.com/raw/wgkJgazE")

        imageCollectionView.dataSource = self

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        DispatchQueue.global(qos: .userInitiated).async {
            self.JSONImageService.fetchJSON(jsonURL: "https://pastebin.com/raw/wgkJgazE")

        }
       loadPullToRefresh()
    }

    func loadPullToRefresh(){
        
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)

     

        imageCollectionView.dg_addPullToRefreshWithActionHandler({
            let json = self.JSONImageService.getJsonObj()
            for imageURL in json{
                self.imageURLs.append(imageURL.urls.regular)
            }
            print("Loaded From: ", self.JSONImageService.returnLoadedFrom())

            self.imageCollectionView.reloadData()
            self.imageCollectionView.dg_stopLoading()
        }, loadingView: loadingView)
        
        imageCollectionView.dg_setPullToRefreshFillColor(UIColor.yellow)
        imageCollectionView.dg_setPullToRefreshBackgroundColor(UIColor.red)
    }
    
    deinit {
        imageCollectionView.dg_removePullToRefresh()
    }
    
    func loadImagetoView(){
        let json = JSONImageService.getJsonObj()
        for imageURL in json{

        }
        self.JSONImageService.fetchJSON(jsonURL: "https://pastebin.com/raw/wgkJgazE")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }

   
    
}
extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return (imageURLs.count)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? CustomCollectionViewCell{
    
           
            JSONImageService.getImage(withURL: URL(string: imageURLs[indexPath.row])!, completion: { (image) in
                cell.imageView.image = image
                
            })
            cell.clipsToBounds = true
            cell.imageView.contentMode = .scaleAspectFill
            cell.layer.cornerRadius = 15
            return cell

        }
            return UICollectionViewCell()
    }
}

