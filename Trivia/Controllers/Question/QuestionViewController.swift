//
//  QuestionViewController.swift
//  Trivia
//
//  Created by Sebastian San Blas on 27/10/2021.
//

import UIKit

class QuestionViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var questionLabel: UILabel!
    
    private let questions = Contenido.shared.obtenerPreguntas()
    private var currentQuestionIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setCurrentQuestion(for: currentQuestionIndex)
    }
    
    //Actions
    @IBAction func wrongAnswerTapped(_ sender: UIButton) {
        let result = validateCurrentQuestion(answer: false)
        sendResultMessage(for: result)
        updateQuestion()
    }
    
    @IBAction func rightAnswerTapped(_ sender: UIButton) {
        let result = validateCurrentQuestion(answer: true)
        sendResultMessage(for: result)
        updateQuestion()
    }
    
}

extension QuestionViewController {
    
    private func validateCurrentQuestion(answer: Bool) -> Bool {
        questions[currentQuestionIndex].answer == answer
    }
    
    private func sendResultMessage(for result: Bool) {
        let message = result ? "La respuesta es correcta! 🥳" : "La respuesta es incorrecta 🥶"

        showAlert(title: "Respuesta",
                  message: message,
                  actions: ["OK"])
    }
    
    private func updateQuestion() {
        currentQuestionIndex += 1
        setCurrentQuestion(for: currentQuestionIndex)
    }
    
    func setCurrentQuestion(for index: Int) {
        if index < questions.count {
            questionLabel.text = questions[index].question
        } else {
            currentQuestionIndex = 0
            questionLabel.text = questions[currentQuestionIndex].question
        }
    }
}

extension QuestionViewController {
    
    func showAlert(title: String, message: String?, actions: [String]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { value in
            alert.addAction(UIAlertAction(title: value, style: .default, handler: nil))
        }
        self.present(alert, animated: true)
    }
}
