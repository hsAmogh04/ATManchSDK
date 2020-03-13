//
//  Movie.swift
//  NetworkLayer
//
//  Created by Malcolm Kumwenda on 2018/03/08.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation

struct ESignRes : Codable {
    let requestId: String
    let responseCode: String
    let message: String?
    let data: RequestXml
}


struct RequestXml : Codable {
    let requestXML: String
}

struct ESignPostReq: Codable {
    let responseXML: String
}

struct PostXmlResponse: Codable {
    let requestId: String
    let responseCode:String
    let message:String
    let data:String
}


struct TransactionData: Codable {
    let transactionId: Int?
    let referenceId:String?
    let transactionLink: String?
    let transactionState:String?
    let documents:[Document]?
}

struct TransactionData1: Codable {
    let transactionId: String?
    let transactionLink: String?
    let transactionState:String?
    let documents:[Document]?
}

struct Document: Codable {
    let documentType: String?
    let documentURL:String?
    let documentId: Int?
    let documentStorageId:String?
    let signerInfo:[SignerInfo]?
    let documentLink: String?
    
}

struct SignerInfo: Codable {
    let commonName: String
    let title:String
   
}



