//
//  SavedLinksModel.swift
//  SummerPractiseIOSLab
//
//  Created by Amir on 09/04/2019.
//  Copyright © 2019 itisIOSLab. All rights reserved.
//

import Foundation

class SavedLinks: NSObject, NSCoding {
    
    var title = String()
    var URL = String()
    
    init(title: String, URL: String) {
        self.title = title
        self.URL = URL
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(forKey: "title") as! String
        self.URL = aDecoder.decodeObject(forKey: "URL") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey:"title")
        aCoder.encode(URL, forKey:"URL")
    }
}

