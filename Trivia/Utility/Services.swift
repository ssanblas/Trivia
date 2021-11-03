//
//  Services.swift
//  Trivia
//
//  Created by Sebastian San Blas on 29/10/2021.
//

import Foundation
import Alamofire

class Services {
    
    private static let endpointURL = "https://opentdb.com"
    
    static var apiCategories: String {
        return String(format: "%@/api_category.php", endpointURL)
    }
    
    static func apiQuestions(ID: Int? = nil) -> String {
        guard ID != nil else {
            return String(format: "%@/api.php?amount=10&type=boolean", endpointURL)
        }
        return String(format: "%@/api.php?amount=10&category=%@", endpointURL, String(ID ?? 0))
    }
    
    static func getServices(url: String, completion: @escaping (Result<Data?, AFError>) -> Void) {
        AF.request(url).response { response in
            completion(response.result)
        }
    }
}
