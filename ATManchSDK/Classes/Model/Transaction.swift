//
//  Movie.swift
//  NetworkLayer
//
//  Created by Malcolm Kumwenda on 2018/03/08.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation

typealias Codable = Encodable & Decodable

struct ManchResponse : Codable {
    let requestId: String
    let responseCode: String
    let message: String?
    let referenceId: String?
}

struct CreateTransactionResponse: Codable {
    let  requestId: String?
    let  referenceId: String?
    let  message: String?
    let  responseCode: String?
    let data:TxnData?
}

struct StatusResponse: Codable {
    let  requestId: String?
    let  message: String?
    let  responseCode: String?
    let data:TransactionData1?
}


struct geteSignResponse: Codable {
    let  requestId: String?
    let  message: String?
    let  responseCode: String?
    let data:eSignData?
}

struct eSignData: Codable {
    let espName:String?
    let signURL: String?
}


struct TxnData: Codable {
    let transaction:TransactionData?
    let documents: [Document]?
    let esignMethod: String?
}
//
//    private enum CreateTransactionResponseCodingKeys: String, CodingKey {
//        case requestId = "requestId"
//        case responseCode = "responseCode"
//        case message = "message"
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CreateTransactionResponseCodingKeys.self)
//
//        requestId = try container.decode(Int.self, forKey: .requestId)
//        responseCode = try container.decode(String.self, forKey: .responseCode)
//        message = try container.decode(String.self, forKey: .message)
//
//    }
//}


struct CreateTransactionReq : Codable {
    let  templateKey: String
    let  firstName: String
    let  lastName:String
    let  esignMethod:String
//    let  mobileNumber:String?
//    let  email:String?
//    let  preAuth:String
    let  documents: [DocumentReq]
    let  callbackURL: String?
}

//{,"esignMethod":"OTP","firstName":"Atmaram","lastName":"Thakur","templateKey":"TMPTS00357"}


//extension CreateTransactionReq: Decodable {
//
//    private enum CreateTransactionReqCodingKeys: String, CodingKey {
//        case templateKey = "templateKey"
//        case firstName = "firstName"
//        case lastName = "lastName"
//        case esignMethod = "esignMethod"
//        case mobileNumber = "mobileNumber"
//        case email = "email"
//        case preAuth = "preAuth"
//        case documents = "documents"
//    }

//    init(){
//         templateKey = "templateKey"
//         firstName = "firstName"
//         lastName = "lastName"
//         esignMethod = "esignMethod"
//         mobileNumber = "mobileNumber"
//         email = "email"
//         preAuth = "preAuth"
//         documents = [DocumentReq()]
//    }
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CreateTransactionReqCodingKeys.self)
//
//        templateKey = try container.decode(String.self, forKey: .templateKey)
//        firstName = try container.decode(String.self, forKey: .firstName)
//        lastName = try container.decode(String.self, forKey: .lastName)
//        esignMethod = try container.decode(String.self, forKey: .esignMethod)
//        mobileNumber = try container.decode(String.self, forKey: .mobileNumber)
//        email = try container.decode(String.self, forKey: .email)
//        preAuth = try container.decode(String.self, forKey: .preAuth)
//        documents = [try container.decode(DocumentReq.self, forKey: .documents)]
//
//    }
//}

struct SignDocRequest: Codable {
    let otp:String
    let preAuth:String
}


struct DocumentReq: Codable {
    let documentType:String
    let documentStorageId:String?
    let documentBytes:String?
    let documentTypeUrl:String
}

//extension DocumentReq: Decodable {
//
//    private enum DocumentReqCodingKeys: String, CodingKey {
//        case documentType = "documentType"
//        case documentStorageId = "documentStorageId"
//        case documentBytes = "documentBytes"
//        case documentTypeUrl = "documentTypeUrl"
//    }
//
//    init() {
//         documentType = "documentType"
//         documentStorageId = "documentStorageId"
//         documentBytes = "documentBytes"
//         documentTypeUrl = "documentTypeUrl"
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: DocumentReqCodingKeys.self)
//
//        documentType = try container.decode(String.self, forKey: .documentType)
//        documentStorageId = try container.decode(String.self, forKey: .documentStorageId)
//        documentBytes = try container.decode(String.self, forKey: .documentBytes)
//        documentTypeUrl = try container.decode(String.self, forKey: .documentTypeUrl)
//
//    }
//}
//
extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
