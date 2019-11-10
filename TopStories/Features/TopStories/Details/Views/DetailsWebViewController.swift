//
//  DetailsWebViewController.swift
//  TopStories
//
//  Created by Abdullah Bayraktar on 7.11.2019.
//  Copyright © 2019 Abdullah Bayraktar. All rights reserved.
//

import UIKit
import WebKit

final class DetailsWebViewController: LoadableViewController {
  
    /// Outlets
    @IBOutlet private weak var webView: WKWebView!

    /// View model
    var viewModel: DetailsWebViewModel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.navigationDelegate = self
        setupToolBar()
        sendRequest(urlString: viewModel.url)
    }
}

// MARK: - Helpers

private extension DetailsWebViewController {
    
    func sendRequest(urlString: String?) {
        guard let urlString = urlString,
            let myURL = URL(string: urlString) else {
                return
        }
        let myRequest = URLRequest(url: myURL)
        webView.load(myRequest)
    }
    
    func setupToolBar() {
      let screenWidth = self.view.bounds.width
      let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
      
      let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
      toolBar.isTranslucent = false
      toolBar.translatesAutoresizingMaskIntoConstraints = false
      
      toolBar.items = [backButton]
      webView.addSubview(toolBar)
      
      toolBar.bottomAnchor.constraint(equalTo: webView.bottomAnchor, constant: 0).isActive = true
      toolBar.leadingAnchor.constraint(equalTo: webView.leadingAnchor, constant: 0).isActive = true
      toolBar.trailingAnchor.constraint(equalTo: webView.trailingAnchor, constant: 0).isActive = true
    }
}

// MARK: - Actions

private extension DetailsWebViewController {
    
    @objc func goBack() {
      if webView.canGoBack {
        webView.goBack()
      } else {
        self.dismiss(animated: true, completion: nil)
      }
    }
}

// MARK: - WKNavigationDelegate

extension DetailsWebViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.showActivityIndicator(show: false)
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.setActivityIndicator(for: webView)
        self.showActivityIndicator(show: true)
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.showActivityIndicator(show: false)
    }
}
