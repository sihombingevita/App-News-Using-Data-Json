//
//  DetailsViewController.swift
//  iOSNewsApp
//
//  Created by Evita Sihombing on 07/03/24.
//

import UIKit
import WebKit

class DetailsViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    var articleLink: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView(frame: view.bounds)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(webView)
        
        //load the article
        if let link = articleLink, let url = URL(string: link) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    @nonobjc func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("Failed to load webpage: \(error.localizedDescription)")
    }    
}
