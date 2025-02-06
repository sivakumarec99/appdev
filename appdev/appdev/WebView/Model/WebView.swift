//
//  WebView.swift
//  appdev
//
//  Created by JIDTP1408 on 03/02/25.
//

import Foundation
import WebKit

class WebViewViewModel: NSObject, ObservableObject {
    
    @Published var isLoading: Bool = true
    @Published var errorMessage: String?
    var webView: WKWebView
    
    // Define allowed domains (for security)
    private let allowedDomains = ["stackoverflow.com", "apple.com"]
    
    init(webView: WKWebView) {
        self.webView = webView
        super.init()
        self.webView.navigationDelegate = self
    }
    
    func loadURL(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid URL"
            return
        }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

// MARK: - WKNavigationDelegate (Handles Web Navigation)
extension WebViewViewModel: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        print(webView.url?.absoluteString as Any)
        isLoading = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        isLoading = false
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        isLoading = false
        errorMessage = error.localizedDescription
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let host = navigationAction.request.url?.host, !allowedDomains.contains(where: host.contains) {
            errorMessage = "Navigation blocked for security reasons."
            decisionHandler(.cancel)
            return
        }
        decisionHandler(.allow)
    }
}
