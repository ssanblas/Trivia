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
    @IBOutlet weak var rightAnswer: UIButton!
    @IBOutlet weak var wrongAnswer: UIButton!
    
    private var viewModel: QuestionsViewModel!
    
    var categoryID: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = QuestionsViewModel(questionsServices: QuestionsServices())
        questionLabel.text = viewModel?.questionLabel
        rightAnswer.isEnabled = false
        wrongAnswer.isEnabled = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getQuestions(for: categoryID) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.setCurrentQuestion()
            self?.rightAnswer.isEnabled = self!.viewModel.enableButton()
            self?.wrongAnswer.isEnabled = self!.viewModel.enableButton()
        }
    }

    //Actions
    @IBAction func wrongAnswerTapped(_ sender: UIButton) {
        let result = viewModel.validateCurrentQuestion(answer: false)
        questionLabel.text = viewModel.getCurrentQuestion()
        sendResultMessage(for: result)
    }
    
    @IBAction func rightAnswerTapped(_ sender: UIButton) {
        let result = viewModel.validateCurrentQuestion(answer: true)
        questionLabel.text = viewModel.getCurrentQuestion()
        sendResultMessage(for: result)
    }
    
}

extension QuestionViewController {
    
    private func setCurrentQuestion() {
        questionLabel.text = viewModel.getCurrentQuestion()
    }
    
    private func sendResultMessage(for result: Bool) {
        let message = result ? "La respuesta es correcta! 🥳" : "La respuesta es incorrecta 🥶"

        showAlert(title: "Respuesta",
                  message: message,
                  actions: ["OK"])
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
