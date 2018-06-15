//
//  ImageLoadingLibraryTests.swift
//  ImageLoadingLibraryTests
//
//  Created by Mewan Chathuranga on 12/06/2018.
//  Copyright © 2018 Mewan Chathuranga. All rights reserved.
//

import XCTest
@testable import ImageLoadingLibrary

class ImageLoadingLibraryTests: XCTestCase {
    
    func testJsonParsing(){
        var jsonService = JSONLoadService()
        var obj = [documentRoot]()

        jsonService.fetchDocument(docURL: "https://images.unsplash.com/photo-1464550883968-cec281c19761")

        print("JSON Count:", jsonData)

        //print("Count", obj.count)
        XCTAssertNotNil(jsonData)
        
    }
    
    func testImageDownload(){
        var imageDownloadService = ImageLoadService()
        var obj = [documentRoot]()
        var thisImage: UIImage? = nil
        
        imageDownloadService.downloadImage(withURL: URL(string: "https://images.unsplash.com/photo-1464550883968-cec281c19761")!) { (image) in
            thisImage = image
        }
            XCTAssertNotNil(thisImage)
        
        

    }
}
