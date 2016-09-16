//
//  Articles.swift
//  NewsAppParsing
//
//  Created by Admin on 15.09.16.
//  Copyright © 2016 Bobrovnikov. All rights reserved.
//

import Foundation
import UIKit

struct Articles {
    
    
    var author: String = ""
    var title: String = ""
    var description: String = ""
    var url: String = ""
    var urlToImage: String = ""
    var publishedAt: String = ""
    

    var image: UIImage?
    
        
    
    init () {
    
    if let imageURL = URL(string: urlToImage), let imageData = try? Data(contentsOf: imageURL) {
        self.image = UIImage(data: imageData)
    }

 }


}
 

