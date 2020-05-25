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
    
    var webView: WKWebView!
    var progressView: UIProgressView!
    var backButton: UIBarButtonItem!
    var forwardButton: UIBarButtonItem!
    
    var loadUrl: String?

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let loadUrl = loadUrl {
            let url = URL(string: "https://\(loadUrl)")!
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
        }
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        backButton = UIBarButtonItem(title: "◀", style: .plain, target: webView, action: #selector(webView.goBack))
        backButton.isEnabled = false

        forwardButton = UIBarButtonItem(title: "▶", style: .plain, target: webView, action: #selector(webView.goForward))
        forwardButton.isEnabled = false
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        toolbarItems = [backButton, forwardButton, space, progressButton, space, refreshButton]
        navigationController?.isToolbarHidden = false
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.canGoBack), options: .new, context: nil)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.canGoForward), options: .new, context: nil)
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
        } else if keyPath == "canGoBack" {
            backButton.isEnabled = webView.canGoBack
        } else if keyPath == "canGoForward" {
            forwardButton.isEnabled = webView.canGoForward
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
