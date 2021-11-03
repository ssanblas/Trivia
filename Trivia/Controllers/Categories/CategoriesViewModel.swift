//
//  CategoriesViewModel.swift
//  Trivia
//
//  Created by Sebastian San Blas on 01/11/2021.
//

import Foundation

class CategoriesViewModel {
    
    private let categoriesService: CategoriesServices
    var categories = [Category]()
    
    init(categoriesService: CategoriesServices) {
        self.categoriesService = categoriesService
    }
    
    func getCategories(completion: @escaping () -> Void) {
        categoriesService.getCategories { result in
            self.categories = result
            completion()
        }
    }
}
