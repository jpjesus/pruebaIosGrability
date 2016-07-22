//
//  Application.swift
//  PruebaIOS
//
//  Created by Jesus Alberto on 18/07/16.
//  Copyright (c) 2016 Jesus Alberto. All rights reserved.
//
import UIKit

public struct Application: Decodable {
    // 1
    public let name: String
    public let link: String
    public let sumary:String
    public let category: String
    public let appId: String
    public let legal :String
    public let price:String
    public let images: [Image]?
    
    public init?(json: JSON) {
        // 2
        guard let container: JSON = "im:name" <~~ json,
            let id: JSON = "id" <~~ json,
            let resume: JSON = "summary" <~~ json,
            let categ: JSON = "category" <~~ json,
            let attribute: JSON = "attributes" <~~ categ,
            let attributes: JSON = "attributes" <~~ id,
            let rights: JSON = "rights" <~~ json,
            let prices: JSON = "im:price" <~~ json
            else { return nil }
        
        guard let name: String = "label" <~~ container,
            link: String = "label" <~~ id,
            appId: String = "im:id" <~~ attributes,
            sumary: String = "label" <~~ resume,
            category: String = "label" <~~ attribute,
            legal: String = "label" <~~ rights,
            price: String = "label" <~~ prices
            else { return nil }
        
        
        images = "im:image" <~~ json
        
        self.sumary=sumary
        self.name = name
        self.link = link
        self.category = category
        self.appId = appId
        self.legal=legal
        self.price=price
        
    }
    
}
