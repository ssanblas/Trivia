//
//  InitialViewController.swift
//  Trivia
//
//  Created by Sebastian San Blas on 26/10/2021.
//

import UIKit

class InitialViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var logo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLogoView()
        userTextField.delegate = self
        animateKeyboard()
    }

    @IBAction func startTriviaTapped(_ sender: Any) {
        if userTextField.hasText {
            goToQuestionController()
        } else {
            showAlert(title: "Debe completar con su nombre para continuar",
                      message: nil,
                      actions: ["OK"])
        }
    }
}

extension InitialViewController {
    
    func setUpLogoView() {
        // Circle effect
        logo.layer.masksToBounds = false
        logo.layer.cornerRadius = logo.frame.height/2
        logo.clipsToBounds = true
        // Constraints
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        logo.widthAnchor.constraint(equalToConstant: logo.frame.height).isActive = true
        logo.heightAnchor.constraint(equalToConstant: logo.frame.height).isActive = true
        let centerHorizontal = logo.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        NSLayoutConstraint.activate([centerHorizontal])
    }
    
    func goToQuestionController() {
        let vc = QuestionViewController(nibName: "QuestionViewController", bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}

// MARK: Keyboard Configuration
extension InitialViewController {
    
    func animateKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
}

extension InitialViewController {
    
    func showAlert(title: String, message: String?, actions: [String]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { value in
            alert.addAction(UIAlertAction(title: value, style: .default, handler: nil))
        }
        self.present(alert, animated: true)
    }
}
