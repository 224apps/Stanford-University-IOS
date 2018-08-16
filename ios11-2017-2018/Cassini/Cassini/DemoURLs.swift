//
//  DemoURLs.swift
//  Cassini
//
//  Created by Abdoulaye Diallo on 8/16/18.
//  Copyright © 2018 Abdoulaye Diallo. All rights reserved.
//

import Foundation

struct DemoURLs {
    
    static let stanford = Bundle.main.url(forResource: "oval", withExtension: "jpg")
    static  let NASA : [ String:  URL] = {
        
        let NASAURLStrings = [
            "Cassini" : "https://www.jpl.nasa.gov/images/cassini/20090202/pia03883-full.jpg",
            "Earth" : "https://www.nasa.gov/sites/default/files/wave_earth_mosaic_3.jpg",
            "Saturn" : "https://www.nasa.gov/sites/default/files/saturn_collage.jpg"
        ]
        var urls = [String: URL]()
        for ( key, value ) in  NASAURLStrings {
            urls[key] = URL(string: value)
        }
        return urls
    }()
}
