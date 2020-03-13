//
//  MovieEndPoint.swift
//  NetworkLayer
//
//  Created by Malcolm Kumwenda on 2018/03/07.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation


enum NetworkEnvironment {
    case dev
    case production
    case dev2
    case uat
}

enum ManchApi {
    case createTransaction(req: CreateTransactionReq)
    case requestXML
    case responseXML(req:ESignPostReq)
    case eSign
    case txnStatus(req: String)
     case getSignDoc(req: String)
    case sendOTP
    case geteSign(req: String)
    case signDocument(req: SignDocRequest)
}

extension ManchApi: EndPointType {
    
    var environmentBaseURL : String {
        var baseUrl = ""
        switch NetworkManager.environment {
        case .production : baseUrl = "https://www.manchtech.com/app/"
        case .dev : baseUrl = "https://dev.manchtech.com/app/"
        case .uat : baseUrl = "https://uat.manchtech.com/app/"
        case .dev2 : baseUrl="https://dev2.manchtech.com/app/"
        }
        return baseUrl
    }
    
    
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        
        switch self {
        case .createTransaction(let txn):
                return "api/transactions"
        case .requestXML:
                return "api/v1/mobile-aar/esign/request-xml"
        case .responseXML:
                return "api/v1/mobile-aar/esign/response-xml"
        case .eSign:
                return "app/api/esign"
        case .txnStatus(let url):
                return url+"/status"
        case .sendOTP:
                return "api/v1/mobile-aar/esign/send-otp"
        case .signDocument(let txn):
                return "api/v1/mobile-aar/esign/sign-documents"
        case .geteSign(let url):
            return url+"/sign-url"
        case .getSignDoc(let url):
            return url
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .createTransaction(let txn):
            return .post
        case .requestXML:
            return .get
        case .responseXML:
            return .post
        case .eSign:
            return .post
        case .txnStatus:
            return .get
        case .sendOTP:
            return .post
        case .geteSign:
            return .get
        case .getSignDoc:
            return .get
        case .signDocument(let txn):
            return .post
            
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .createTransaction(let req as CreateTransactionReq):
            return .requestParametersAndHeaders(bodyParameters:req.dictionary,
                                      bodyEncoding: .jsonEncoding,
                                      urlParameters: nil,
                                      additionHeaders: headers
            )
        case .requestXML:
            return .requestParametersAndHeaders(bodyParameters:nil,
                                                bodyEncoding: .jsonEncoding,
                                                urlParameters: nil,
                                                additionHeaders: headers
            )
        case .responseXML(let req as ESignPostReq):
            return .requestParametersAndHeaders(bodyParameters:req.dictionary,
                                                bodyEncoding: .jsonEncoding,
                                                urlParameters: nil,
                                                additionHeaders: headers
            )
        case .eSign:
            return .requestParametersAndHeaders(bodyParameters:nil,
                                                bodyEncoding: .jsonEncoding,
                                                urlParameters: nil,
                                                additionHeaders: headers
            )
        case .txnStatus(let url as String):
            return .requestParametersAndHeaders(bodyParameters:nil,
                                                bodyEncoding: .jsonEncoding,
                                                urlParameters: nil,
                                                additionHeaders: headers
            )
        case .getSignDoc(let url as String):
            return .requestParametersAndHeaders(bodyParameters:nil,
                                                bodyEncoding: .jsonEncoding,
                                                urlParameters: nil,
                                                additionHeaders: headers
            )
        case .geteSign(let url as String):
            return .requestParametersAndHeaders(bodyParameters:nil,
                                                bodyEncoding: .jsonEncoding,
                                                urlParameters: nil,
                                                additionHeaders: headers
            )
        case .sendOTP:
            return .requestParametersAndHeaders(bodyParameters:[:],
                                                bodyEncoding: .jsonEncoding,
                                                urlParameters: nil,
                                                additionHeaders: headers
            )
        case .signDocument(let req as SignDocRequest):
            return .requestParametersAndHeaders(bodyParameters:req.dictionary,
                                                bodyEncoding: .jsonEncoding,
                                                urlParameters: nil,
                                                additionHeaders: headers
            )
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return ["AUTHORIZATION":NetworkManager.authenticationToken,
                "REQUEST-ID":NetworkManager.requestId,
                "CONTENT-TYPE": "application/json",
                "ACCEPT-TRANSACTION-ON-SIGN": "Y"]
    }
}


