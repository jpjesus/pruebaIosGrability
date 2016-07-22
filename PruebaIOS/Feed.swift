//
//  Feed.swift
//  PruebaIOS
//
//  Created by Jesus Alberto on 18/07/16.
//  Copyright (c) 2016 Jesus Alberto. All rights reserved.
//

import UIKit

public struct Feed: Decodable {
    
    public let entries: [Application]?
    
    public init?(json: JSON) {
        entries = "entry" <~~ json
    }
    
}