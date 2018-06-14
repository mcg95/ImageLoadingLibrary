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
    
    let ImageService = ImageLoadService()
    let JSONService = JSONLoadService()
    
    var imageURLs: [String] = []
    let cellId = "photoCell"

    @IBOutlet weak var imageCollectionView: UICollectionView!
 
    
    @IBAction func refreshBtn(_ sender: Any) {
     
        imageCollectionView.reloadData()

        print("Refreshed!!!")

    }
    
    fileprivate func loadPullToRefresh(){
        
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
        
        imageCollectionView.dg_addPullToRefreshWithActionHandler({
  
            print("Loaded From: ", self.ImageService.returnLoadedFrom())
            
            self.imageCollectionView.reloadData()
            self.imageCollectionView.dg_stopLoading()
        }, loadingView: loadingView)
        
        imageCollectionView.dg_setPullToRefreshFillColor(UIColor.yellow)
        imageCollectionView.dg_setPullToRefreshBackgroundColor(UIColor.red)
    }
    
    deinit {
        imageCollectionView.dg_removePullToRefresh()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        DispatchQueue.global(qos: .userInitiated).async {
            self.JSONService.fetchDocument(docURL: "https://pastebin.com/raw/wgkJgazE")
        }
        loadPullToRefresh()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let json = JSONService.getDocumentObj()
        for imageURL in json{
            self.imageURLs.append(imageURL.urls.small)

        }
        imageCollectionView.dataSource = self

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
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? CustomCollectionViewCell{
            
            print(imageURLs[indexPath.row])
            print("URL Count: ", imageURLs.count)
                self.ImageService.getImage(withURL: URL(string: self.imageURLs[indexPath.row])!, completion: { (image) in
                    cell.imageView.image = image
                    print(image?.cgImage)
                
            })
            
            cell.clipsToBounds = true
            cell.imageView.contentMode = .scaleAspectFill
            cell.layer.cornerRadius = 15
            
            return cell
            
        }
            return UICollectionViewCell()
    }
    
}

