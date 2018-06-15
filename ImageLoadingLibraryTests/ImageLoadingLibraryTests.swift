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
    
    DispatchQueue.global(qos: .background).async {
        jsonService.fetchDocument(docURL: "http://pastebin.com/raw/wgkJgazE")

    }
    DispatchQueue.main.async {
        obj = jsonService.getDocumentObj()

        print("Object Count: ", obj.count)

    }
    XCTAssertNotNil(obj)

        //print("Count", obj.count)
    }
    
    func testImageDownloading(){
        var jsonService = ImageLoadService()
        var imageDownloaded: UIImage? = nil
        DispatchQueue.global(qos: .background).async {
            
            jsonService.downloadImage(withURL: URL(string: "https://images.unsplash.com/photo-1464550883968-cec281c19761")!) { (image) in
                imageDownloaded = image
                print("Access identifier: ", image?.accessibilityIdentifier)

        }
        }
        print("Access identifier: ", imageDownloaded?.accessibilityIdentifier)

        XCTAssertNotNil(imageDownloaded?.cgImage)

    }
    
}
