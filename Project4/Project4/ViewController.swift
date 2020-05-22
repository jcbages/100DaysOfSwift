//
//  ViewController.swift
//  Project4
//
//  Created by Juan Camilo Bages Prada on 5/21/20.
//  Copyright © 2020 Juan Camilo Bages Prada. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    let WEBSITES = [
        "apple.com",
        "hackingwithswift.com"
    ]
    
    var webView: WKWebView!

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))

        let url = URL(string: "https://www.hackingwithswift.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }

    @objc func openTapped() {
        let ac = UIAlertController(title: "Open page 🚀", message: nil, preferredStyle: .actionSheet)

        WEBSITES.forEach { url in
            ac.addAction(UIAlertAction(title: url, style: .default, handler: openPage))
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }

    func openPage(action: UIAlertAction) {
        guard let actionTitle = action.title else {
            return
        }

        guard let url = URL(string: "https://\(actionTitle)") else {
            return
        }

        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if let webViewTitle = webView.title {
            title = "📱 \(webViewTitle)"
        }
    }
}

