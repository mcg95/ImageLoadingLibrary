//
//  JSONStructure.swift
//  ImageLoadingLibrary
//
//  Created by Mewan Chathuranga on 13/06/2018.
//  Copyright © 2018 Mewan Chathuranga. All rights reserved.
//

import Foundation

struct jsonRoot: Decodable{
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
