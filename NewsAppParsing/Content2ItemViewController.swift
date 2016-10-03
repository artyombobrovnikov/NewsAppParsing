//
//  Content2TableViewController.swift
//  NewsAppParsing
//
//  Created by Admin on 03.10.16.
//  Copyright © 2016 Bobrovnikov. All rights reserved.
//

import UIKit

class Content2ItemViewController: UIViewController {
    
// MARK: - Outlets
    @IBOutlet weak var webView: UIWebView!
    
// MARK: - Properties
    var urlString: String?
    
// MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
// MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let urlString = urlString, let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.loadRequest(request)
        }
    }
}

