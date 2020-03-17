//
//  ManchViewController.swift
//  ManchSDK
//
//  Created by Atmaram on 10/10/19.
//  Copyright © 2019 Atmaram. All rights reserved.
//

import UIKit
import WebKit

class  ManchViewController: UIViewController ,WKNavigationDelegate {
    
    var webView: WKWebView!
    var deligate: ManchListener?
    
    @IBOutlet weak var otpField: UITextField!
   
    var signUrl = ""
    var transactionUrl = "";
    
    
    override func loadView() {
        webView = WKWebView()
        
        webView.navigationDelegate = self
        view = webView
        
        let url = URL(string: signUrl)!
        print("loading \(signUrl)")
        self.webView.load(URLRequest(url: url))
    }
    @IBAction func onClick(_ sender: Any) {
        if(!otpField.text!.isEmpty){
            //            SignDocRequest()
        }
    }
   
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse,
                 decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        if let response = navigationResponse.response as? HTTPURLResponse {
            print("response.statusCode :: \(response.statusCode)")
            if response.statusCode != 200 {
                deligate?.eventCompleted(mode: 1, data: "Failure from URL\(response.url) with response Code \(response.statusCode)")
                dismiss(animated: true, completion: nil)
            }
        }
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if let host = navigationAction.request.url?.absoluteString {
            if host.contains(".manchtech.com/nsdl-esp/authenticate/esignCancel"){
//                dismiss(animated: true, completion: nil)
                deligate?.eventCompleted(mode: 1, data: "Cancelled")
                 dismiss(animated: true, completion: nil)
            }
            else if host.starts(with:".manchtech.com/redirect/webview-post-esign.html?"){
               print("transactionUrl \(transactionUrl)")
                deligate?.eventCompleted(mode: 0, data: transactionUrl)
//                decisionHandler(.allow)
                dismiss(animated: true, completion: nil)
//                return
            }
        }
        
        decisionHandler(.allow)
    }
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

