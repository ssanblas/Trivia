//
//  QuestionsViewModel.swift
//  Trivia
//
//  Created by Sebastian San Blas on 27/10/2021.
//

import Foundation
import ProgressHUD

final class QuestionsViewModel {

    private let questionsServices: QuestionsServices
    
    private var questions: [Question] = [Question(category: "", question: "", correctAnswer: "True")]
    var currentQuestionIndex: Int = 0
    
    var questionLabel: String = ""
    
    init(questionsServices: QuestionsServices) {
        self.questionsServices = questionsServices
    }
    
    func getQuestions(for categoryID: Int?, completion: @escaping () -> Void) {
        ProgressHUD.show()
        questionsServices.getQuestions(for: categoryID) { result in
            self.questions = result
            completion()
        }
    }
    
    func validateCurrentQuestion(answer: Bool) -> Bool {
        updateQuestion()
        return questions[currentQuestionIndex].correctAnswer == "True"
    }
    
    private func updateQuestion() {
        currentQuestionIndex += 1
        setCurrentQuestion(for: currentQuestionIndex)
    }
    
    private func setCurrentQuestion(for index: Int) {
        if index < questions.count {
            questionLabel = questions[index].question
        } else {
            currentQuestionIndex = 0
            questionLabel = questions[currentQuestionIndex].question
        }
    }
    
    func getCurrentQuestion() -> String {
        guard !questions.isEmpty else {
            return ""
        }
        return questions[currentQuestionIndex].question.htmlDecoded
    }
    
    func enableButton() -> Bool {
        if getCurrentQuestion() == "" {
            return false
        }
        return true
    }
}

extension String {
    var htmlDecoded: String {
        let decoded = try? NSAttributedString(data: Data(utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ], documentAttributes: nil).string

        return decoded ?? self
    }
}
