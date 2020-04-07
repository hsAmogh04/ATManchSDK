//
//  ViewController.swift
//  ATManchSDK
//
//  Created by AmoghHS on 03/14/2020.
//  Copyright (c) 2020 AmoghHS. All rights reserved.
//

import UIKit
import ATManchSDK

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//         let sdkManager = ManchSDKManager()
//            let fName = "Atmaram"
//                   let lName = "Thakur"
////                   let templateKey = "TMPTS00357"
////                   let docType = "mono external"
////                   let orgKey = "TST00019"
////                   let securityKey = "cPaQHY4RS1Sncoxr"
//                        let templateKey = "TMPTS01124"
//                         let docType = "Equity Form"
//                         let orgKey = "TST00113"
//                         let securityKey = "Nbj329oPtjQm3XjA"
//                   let docUrl = "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf"
//        //           let preAuthType = "N"
//                   let environment = "UAT"
//        //           var eSignMethod = "OTP" //EMAIL_OTP, OTP, MOBILE_OTP
//                let timeInMiliSecDate = Date()
//                       let reqId =  "\(timeInMiliSecDate.timeIntervalSince1970 * 1000000 )"
//
//                let authToken = AuthTokenGenerator().generate(orgKey: orgKey, reqId: reqId , securityKey: securityKey)
//
//                let params = ["firstName" : fName,
//                              "lastName": lName,
//                              "templateKey": templateKey,
//                              "documentType": docType,
//                              "environment":environment,
//                              "requestId": reqId,
//                              "authenticationToken": authToken,
//                              "acceptTransaction": "Y",
//                              "documentURL" : "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf",
//                              "orgKey": orgKey,
//                              "securityKey": securityKey
//
//                ]
//                sdkManager.createTransaction(param: params, viewController: self, completionHandler:{ (status, resp) -> Void in
//
//
//                    if status{
//        //                print("DocUrl = \(resp)")
//
//                        let params = ["requestId": reqId,
//                                      "documentURL" : resp,
//                                      "environment" :"DEV",
//                                      "acceptTransaction" : "Y",
//                                      "authenticationToken" : authToken
//                        ]
//                sdkManager.eSignDocument(param: params,viewController: self, completion: {(status, code, response) in
//                            print("Status=\(status) code: \(code) and response = \(response)")
//
//        //                    if status{
//        //                        sdkManager.sendStatusRequest()
//        //                    }
//                        })
//                    }else{
//                        // error case
//                    }
//                    })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

