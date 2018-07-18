//
//  ImageLoadingLibraryTests.swift
//  ImageLoadingLibraryTests
//
//  Created by Mewan Chathuranga on 12/06/2018.
//  Copyright © 2018 Mewan Chathuranga. All rights reserved.
//

import XCTest
import UIKit
@testable import ImageLoadingLibrary

class ImageLoadingLibraryTests: XCTestCase {
    
    func testJsonParsing(){
        var jsonService = JSONLoadService()
        var obj = [documentRoot]()
        let promise = expectation(description: "Json Document Fetched Successfully!")
        
        DispatchQueue.global(qos: .background).async {
            jsonService.fetchDocument(docURL: "https://pastebin.com/raw/wgkJgazE")
            
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute: {
            obj = jsonService.getDocumentObj()
            print("Object Count: ", obj.description)
            
            for objects in obj{
                print("Object URL: ",objects.urls.small)
                print("Object User: ",objects.user.profile_image.large)
                
                if objects.urls.small == "https://images.unsplash.com/photo-1464519046765-f6d70b82a0df?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&w=400&fit=max&s=b28e48601f9d332f5ba92c8d49cdbf83"{
                    promise.fulfill()
                }
                
            }
            
            
        })
        
        waitForExpectations(timeout: 10, handler: nil)
        
        //print("Count", obj.count)
    }
    
    func testImageDownloading(){
        var jsonService = ImageLoadService()
        var imageDownloaded: UIImage? = nil
        let promise = expectation(description: "Image Downloaded Succesfully.")
        DispatchQueue.global(qos: .background).async {
            
            jsonService.downloadImage(withURL: URL(string: "https://images.unsplash.com/photo-1464550883968-cec281c19761")!) { (image) in
                imageDownloaded = image
                
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
            if imageDownloaded?.cgImage != nil{
                print("Access identifier: ", imageDownloaded?.cgImage)
                promise.fulfill()
            }
        })
        
        waitForExpectations(timeout: 8, handler: nil)
        
    }
    
}
