//
//  WebKitViewController.swift
//  tabbedAppPract
//
//  Created by Amir on 01/04/2019.
//  Copyright © 2019 Amir. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var model: SavedLinks!
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.addSubview(webView)
        let url = URL(string: model.URL)
        webView.load(URLRequest(url: url!))
        self.navigationItem.title = model.title
        
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        self.navigationController?.toolbar.isHidden = true
        toolbarItems = [refresh]
        navigationController?.isToolbarHidden = false
    }
}
