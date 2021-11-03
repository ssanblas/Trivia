//
//  QuestionsServices.swift
//  Trivia
//
//  Created by Sebastian San Blas on 01/11/2021.
//

import Foundation
import ProgressHUD

class QuestionsServices {
    
    func getQuestions(for categoryID: Int?, completion: @escaping ([Question]) -> Void) {
        let questionsURL = Services.apiQuestions(ID: categoryID)
        Services.getServices(url: questionsURL) { response in
            switch response {
            case .success(let data):
                do {
                    guard data != nil else {
                        completion([])
                        ProgressHUD.showError()
                        return
                    }
                    let questions = try JSONDecoder().decode(AllBody.self, from: data!)
                    ProgressHUD.dismiss()
                    completion(questions.results)
                } catch {
                    ProgressHUD.showError("Falló.", image: nil, interaction: true)
                    completion([])
                }
            case .failure(let error):
                print(error)
                ProgressHUD.showError("Se agotó el tiempo de espera.", image: nil, interaction: true)
                completion([])
            }
        }
    }
}
