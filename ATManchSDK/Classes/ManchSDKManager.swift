//
//  ManchSDKManager.swift
//  ManchSDK
//
//  Created by Atmaram on 10/10/19.
//  Copyright © 2019 Atmaram. All rights reserved.
//

import Foundation

protocol ManchListener{
    func eventCompleted(mode: Int, data: Any?)
}



public class ManchSDKManager : ManchListener{
    
    public init() {
//        self.reqI
//         networkManager = NetworkManager(reqId: reqId, authToken: authToken)
    }
    
    func eventCompleted(mode: Int, data: Any?) {
        switch mode {
        case 0:
//            if let txnUrl = data as? String , txnUrl.count > 0{
//                sendStatusRequest(docurl: txnUrl)
//            }else{
//                 sendStatusRequest(docurl: transactionUrl)
//            }
            //_completionHandler(true,"")
             _completionHandler(true,data as? String ?? "")
        case 1:
//             self.displayProgressDialog(msg:"Downloading document...")
//            sendStatusRequest(docurl: "")
            _completionHandler(false,data as? String ?? "")
        default:
            print("")
        }
    }
    
    
   
    
    var alert: UIAlertController?
    var networkManager: NetworkManager?
    
    var transactionUrl = "";
    
    var viewController : UIViewController?
    public typealias handler = (Bool, String) -> ()
    var _completionHandler: handler!
    func createTransaction(param: [String:String], viewController: UIViewController, completionHandler :@escaping (Bool, String) -> Void){
        print("Printing \(param)")
        self.viewController = viewController
//        displayProgressDialog(msg:"Creating Transaction...");
        
        // find data from source App
       
        self.sendCreateRequest(param: param, completionHandler: { (status , response) -> Void in
            completionHandler(status, response)
            })
       // _completionHandler = completionHandler
    }
    
    func sendCreateRequest(param : [String: String], completionHandler: @escaping(_ err: Bool, _ resp: String) -> ()){

        let orgKey = param["orgKey"] ?? ""
        let securityKey = param["securityKey"] ?? ""
        let reqId = param["requestId"] ?? ""
        let docUrl = param["documentURL"] ?? ""
        let docType = param["documentType"] ?? ""
        let templateKey = param["templateKey"] ?? ""
        let fName = param["firstName"] ?? ""
        let lName = param["lastName"] ?? ""
        let eSignMethod = "OTP"
        let preAuthType = "Y"
        let mobileNumber = param["mobile"] ?? ""
        let email = param["email"] ?? ""
        let callbackUrl = param["callbackUrl"] ?? "http://dev.manchtech.com:3000/sample-server/esign/callback"
        let authToken = param["authenticationToken"] ??
        AuthTokenGenerator().generate(orgKey: orgKey, reqId: reqId , securityKey: securityKey)
       
        networkManager = NetworkManager()
//        NetworkManager.acceptTransaction = acceptTransaction
        NetworkManager.authenticationToken = authToken
        NetworkManager.requestId = reqId
        
        let documentReq = DocumentReq.init(documentType: docType, documentStorageId: nil, documentBytes: nil, documentTypeUrl: docUrl)
        
        let request = CreateTransactionReq.init(templateKey: templateKey, firstName: fName, lastName: lName, esignMethod: eSignMethod, mobileNumber: mobileNumber, email: email, preAuth: preAuthType, documents: [documentReq], callbackURL: callbackUrl)
        networkManager?.createTransaction(req: request) { resp, error in
            //            print("error = \(error) and resp=\(resp)")
//            completionHandler(error, resp)
            
            if error != nil {
                // error case
                //                self.dismissProgressDialog()
                                completionHandler(false,"error message")
            }else{
                if let createTxnResponse = resp as? CreateTransactionResponse{
                    // handle the response
                    if(createTxnResponse.responseCode == "1"){
                        if let txnUrl = createTxnResponse.data?.transaction?.transactionLink{
                            self.transactionUrl = txnUrl
                            print("transactionUrl : \(txnUrl)")
                        }
                        if let doc = createTxnResponse.data?.documents?[0], let doclink = doc.documentLink{
                            completionHandler(true, doclink)
                            //                            self.sendeSignRequest(docurl: docUrl)
                        }
                    }
                    
                }
        }
    }
    }
    
    public func eSignDocument(param : [String: String], viewController: UIViewController, completion: @escaping(_ status: Bool, _ resp: String) -> ()){
        self._completionHandler = completion
        self.viewController = viewController
        let reqId = param["requestId"] ?? ""
        let docUrl = param["documentURL"] ?? ""
        let acceptTransaction = param["acceptTransaction"] ?? ""
        let authToken = param["authenticationToken"] ?? ""
        let environment = param["environment"] ?? ""
        
        networkManager = NetworkManager()
        NetworkManager.acceptTransaction = acceptTransaction
        NetworkManager.authenticationToken = authToken
        NetworkManager.requestId = reqId
        
        switch environment {
        case "DEV":
            NetworkManager.environment = NetworkEnvironment.dev
        case "PROD":
            NetworkManager.environment = NetworkEnvironment.production
        case "UAT":
            NetworkManager.environment = NetworkEnvironment.uat
        case "DEV2":
            NetworkManager.environment = NetworkEnvironment.dev2
        default:
            NetworkManager.environment = NetworkEnvironment.dev
        }
       
        
        self.networkManager?.getESignUrl(req: docUrl) { resp, error in
            if error != nil {
                self.dismissProgressDialog()
                completion(false,"Unable to Sign Document")
            }else{
                if let esignResponse = resp as? geteSignResponse{
                    if let signUrl = esignResponse.data?.signURL{
                        self.dismissProgressDialog()
                        DispatchQueue.main.async {
                            
                            let bundle = Bundle(identifier: "org.cocoapods.ATManchSDK")
                            let storyboard = UIStoryboard(name: "ManchStoryboard", bundle: bundle)
                            let controller = storyboard.instantiateViewController(withIdentifier: "ManchViewController") as! ManchViewController
                            controller.signUrl = signUrl
                            controller.deligate = self
                            self.viewController?.present(controller, animated: true, completion: nil)
                            
                        }
                    }
                }
                
            }
        }
    }
    
    
    func sendStatusRequest(){
//        docurl = transactionUrl
            self.networkManager?.getTxnStatus(url: transactionUrl) { resp, error in
                print("error = \(error) and resp=\(resp)")
                if error != nil {
                    self.dismissProgressDialog();
                    self._completionHandler(false,"Unable to get Status")
                }else{
                    if let response = resp as? StatusResponse{
                        if let docs = response.data?.documents{
                            // open NSDL page
                            if(docs.count > 0){
                                if let url = docs[0].documentURL{
//                                    DispatchQueue.main.async {
//                                      self.displayDialog(url: url)
//                                    }
//                                    self.displayProgressDialog(msg:"Downloading document...")
                                    self.getSignedDocument(url: url)
                                }
                            }else{
                                // nothing
                            }
                            
                        }else{
                            // show OTP fields in screen
                        }
                    }
                }
            }
        }
    
    
    func displayDialog(url: String){
        let alert = UIAlertController(title: "Alert", message: url, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Open", style: UIAlertAction.Style.default, handler: {action in
            self.getSignedDocument(url: url)
        }))
        self.viewController?.present(alert, animated: true, completion: nil)
    }
    
    func displayProgressDialog(msg: String){
         DispatchQueue.main.async {
            if let alert = self.alert {
                alert.message = msg
                self.alert = alert
            }else{
                self.alert = UIAlertController(title: "", message: msg, preferredStyle: UIAlertController.Style.alert)
            }
        self.viewController?.present(self.alert!, animated: true, completion: nil)
        }
       }
    
    func dismissProgressDialog()  {
         DispatchQueue.main.async {
        self.alert?.dismiss(animated: true, completion: nil)
        }
    }
    
     func getSignedDocument(url: String){
            networkManager?.getSignDoc(url: url) { resp, error in
                 self.dismissProgressDialog()
                if error != nil {
                    // error case
                     self._completionHandler(false,"Unable to get sign document")
                }else{
                    do{
                        if let filename = resp as? URL{
                            //let req = NSURLRequest(url: filename)
                            //self.webView.load(req as URLRequest)
                        print("filename.absoluteString = \(filename.absoluteString)")
//                            self._completionHandler(true,filename.absoluteString)
                        }
                    }catch {
                        print(error)
                    }
                }
            }
        }
    
    
    
      
      func getDocumentsDirectory() -> URL {
          let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
          return paths[0]
      }
}
