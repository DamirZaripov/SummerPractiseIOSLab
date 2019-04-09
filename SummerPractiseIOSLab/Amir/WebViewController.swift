//
//  WebViewController.swift
//  SummerPractiseIOSLab
//
//  Created by Amir on 09/04/2019.
//  Copyright © 2019 itisIOSLab. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var model: SavedLinks!
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureWebView()
    }
    
    fileprivate func configureWebView() {
        let url = URL(string: model.URL)
        webView.load(URLRequest(url: url!))
        self.navigationItem.title = model.title
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        self.navigationController?.toolbar.isHidden = true
        toolbarItems = [refresh]
        navigationController?.isToolbarHidden = false
    }
    
}

