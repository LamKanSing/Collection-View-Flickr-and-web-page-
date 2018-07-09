//
//  WebViewController.swift
//  CollectionView
//
//  Created by kan sing lam
//  Copyright © 2018年 kan sing lam All rights reserved.
//

import UIKit
import WebKit

class WikiViewController: UIViewController , WKNavigationDelegate{
    
    @IBOutlet weak var webView: WKWebView!
    
    var selectedAnimal : Animal?
    var url = URL(string: "https://en.wikipedia.org/wiki/Dog")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        url = URL(string: selectedAnimal?.wikiLinkWord
            ?? "https://en.wikipedia.org/wiki/Dog")!
        
        print("start loading")
        print(url)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        webView.load(URLRequest(url: url))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        webView.stopLoading()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let output : String? = webView.title ?? "" + "testing"
        title = output
    }
    
}
