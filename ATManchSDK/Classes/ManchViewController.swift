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
        super.loadView()
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
                deligate?.eventCompleted(mode: 1, code: "", data: "Failure from URL\(response.url) with response Code \(response.statusCode)")
                dismiss(animated: true, completion: nil)
            }
        }
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if let host = navigationAction.request.url?.absoluteString {
            if host.contains(".manchtech.com/redirect/webview-post-esign.html?"){
               print("transactionUrl \(transactionUrl)")
                let qStr = host.split(separator: "?");
                var responseCode = ""
                var message = ""
                if(qStr.count > 1){
                    let ampStr = qStr[1].split(separator: "&")
                    for str in ampStr {
                        let eqStr = str.split(separator: "=")
                        if(eqStr.count > 1){
                            let key = eqStr[0]
                            let val = eqStr[1]
                            
                            if(key.lowercased() == "responsecode"){
                                responseCode = String(val)
                            }else if(key.lowercased() == "message"){
                                message = String(val)
                                if let decoded = message.decodeString{
                                    message = decoded
                                }
                            }
                        }
                    }
                    
                }
                
                if(responseCode == "1"){
                    deligate?.eventCompleted(mode: 0, code: responseCode, data: message)
                }else{
                    deligate?.eventCompleted(mode: 1, code: responseCode,data: message)
                }
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


extension String {
    public var decodeString: String? {
        var byteArray: [UInt8] = []
        let stringArray: [String] = map { String($0) }
        var index: Int = 0
        while index < stringArray.count {
            let char: String = stringArray[index]
            if char == "%" , (index + 2) < stringArray.count {
                let towChar = stringArray[index+1...index+2].joined()
                if let charCode = UInt8(towChar, radix: 16) {
                    byteArray.append(charCode)
                    index += 3
                }
            } else if char == "+", let hexValue = " ".utf8.first {
                byteArray.append(hexValue)
                index += 1
            } else if let charCode = Array(char.utf8).first {
                byteArray.append(charCode)
                index += 1
            }
        }

        if let decodedString = NSString(bytes: UnsafePointer(byteArray),
                                        length: byteArray.count,
                                        encoding: String.Encoding.shiftJIS.rawValue) {
            return String(decodedString)
        }
        return nil
    }
}

