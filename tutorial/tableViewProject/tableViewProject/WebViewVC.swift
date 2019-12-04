//
//  WebViewVC.swift
//  tableViewProject
//
//  Created by Vladyslav PALAMARCHUK on 12/4/19.
//  Copyright © 2019 Vladyslav PALAMARCHUK. All rights reserved.
//

import UIKit
import WebKit

class WebViewVC: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    // MARK: - Properties
    var url: URL!
    var webView: WKWebView!
    var progressView: UIProgressView!
    
    // MARK: -
    
    deinit {
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        setupToolBar()
        let request = URLRequest(url: url)
        webView.load(request)
        
        
        addCustomToolBar()
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    // MARK: - Setup Methods
    
    func setupWebView() {
        navigationController?.navigationBar.isTranslucent = false
        webView = WKWebView()
        webView.navigationDelegate = self
//        webView.allowsLinkPreview = true
//        webView.uiDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        
        // Constraint
        webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
    
    func setupToolBar() {
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let loadButton = UIBarButtonItem(customView: progressView)
        let flexibleSpacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        let stopButton = UIBarButtonItem(barButtonSystemItem: .stop, target: webView, action: #selector(webView.stopLoading))
        let goBackButton = UIBarButtonItem(image: UIImage(named: "goBack"), style: .plain, target: webView, action: #selector(webView.goBack))
        toolbarItems = [goBackButton, flexibleSpacer, loadButton, flexibleSpacer, refreshButton, flexibleSpacer, stopButton]
        navigationController?.isToolbarHidden = false
    }
    
    // TODO: - tried to add custom tool bar.
    func addCustomToolBar() {
        //        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 160))
        //        toolbar.isTranslucent = false
        //        toolbar.translatesAutoresizingMaskIntoConstraints = false
        //        toolbar.items = [goBackButton, flexibleSpacer, loadButton, flexibleSpacer, refreshButton, flexibleSpacer, stopButton]
        //        view.addSubview(toolbar)
        
        // Constraints
        //        toolbar.bottomAnchor.constraint(equalTo: webView.bottomAnchor, constant: 0).isActive = true
        //        toolbar.leadingAnchor.constraint(equalTo: webView.leadingAnchor, constant: 0).isActive = true
        //        toolbar.trailingAnchor.constraint(equalTo: webView.trailingAnchor, constant: 0).isActive = true
    }
    
    // MARK: - Init progressView
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    // MARK: -
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
}
