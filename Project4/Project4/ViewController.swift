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
    var progressView: UIProgressView!

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))

        let url = URL(string: "https://\(WEBSITES[0])")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        toolbarItems = [progressButton, space, refresh]
        navigationController?.isToolbarHidden = false
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
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
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url

        if let host = url?.host {
            let firstIndex = WEBSITES.firstIndex { website in host.contains(website) }
            if firstIndex != nil {
                decisionHandler(.allow)
                return
            }
        }

        if navigationAction.navigationType != .other {
            let ac = UIAlertController(title: "Forbidden Site", message: "Nope, its just Chuck Testa", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK 😭", style: .cancel))
            present(ac, animated: true)
        }

        decisionHandler(.cancel)
    }
}
