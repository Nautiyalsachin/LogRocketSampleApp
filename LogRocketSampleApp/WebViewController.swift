//
//  WebViewController.swift
//  LogRocketSampleApp
//
//  Created by Sachin Nautiyal on 05/01/22.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadWebView()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            webView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            webView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            webView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
    }
    
    private func loadWebView() {
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
        let mNativeToWebHandler: String = "jsMessageHandler"
        webView.configuration.userContentController.add(self, name: mNativeToWebHandler)
        let url = URL(string: "https://www.google.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = false
    }
    
}

extension WebViewController: WKNavigationDelegate, WKScriptMessageHandler, WKUIDelegate {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
}
