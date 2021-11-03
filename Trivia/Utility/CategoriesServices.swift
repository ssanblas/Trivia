//
//  CategoriesServices.swift
//  Trivia
//
//  Created by Sebastian San Blas on 30/10/2021.
//

import Foundation

class CategoriesServices {

    func getCategories(completion: @escaping ([Category]) -> Void) {
        let categoriesURL = Services.apiCategories
        
        Services.getServices(url: categoriesURL) { response  in
            switch response {
            case .success(let data):
                do {
                    guard data != nil else {
                        completion([])
                        return
                    }
                    let categories = try JSONDecoder().decode(Categories.self, from: data!)
                    completion(categories.allCategories)
                } catch {
                    completion([])
                }
            case .failure(let error):
                print(error)
                completion([])
            }
        }
    }
}
