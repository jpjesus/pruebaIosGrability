//
//  Image.swift
//  PruebaIOS
//
//  Created by Jesus Alberto on 19/7/16.
//  Copyright © 2016 Jesus Alberto. All rights reserved.
//
import Foundation

public struct Image: Decodable {
    
    public let images: String
    public init?(json: JSON) {
        
        guard let images: String = "label" <~~ json
            else { return nil }
        
        self.images=images
    }
    
}