//
//  TopApps.swift
//  PruebaIOS
//
//  Created by Jesus Alberto on 19/7/16.
//  Copyright © 2016 Jesus Alberto. All rights reserved.
//

import Foundation

public struct TopApps: Decodable {
    
    // 1
    public let feed: Feed?
    
    // 2
    public init?(json: JSON) {
        feed = "feed" <~~ json
    }
    
}
