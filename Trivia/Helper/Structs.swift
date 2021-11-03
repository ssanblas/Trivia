//
//  Structs.swift
//  Trivia
//
//  Created by Sebastian San Blas on 27/10/2021.
//
//

struct Questions: Codable {
    let questions: [Question]
}


struct AllBody: Codable {
    let responseCode: Int
    let results: [Question]

    enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
        case results
    }
}

struct Question: Codable {
    let category: String
    let question: String
    var correctAnswer: String
}

extension Question {
    enum CodingKeys: String, CodingKey {
        case category, question
        case correctAnswer = "correct_answer"
    }
}
// MARK: -- Categories

struct Category: Codable {
    let id: Int
    let name: String
}

struct Categories: Codable {
    let allCategories: [Category]
}

extension Categories {
    enum CodingKeys: String, CodingKey {
        case allCategories = "trivia_categories"
    }
}
