//
//  CategoriesViewController.swift
//  Trivia
//
//  Created by Sebastian San Blas on 28/10/2021.
//

import UIKit

class CategoriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private var viewModel: CategoriesViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CategoriesViewModel(categoriesService: CategoriesServices())
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.rowHeight = 80
        tableView.tableFooterView = UIView()
        getCategories()
    }

    private func getCategories() {
        viewModel?.getCategories {
            self.tableView.reloadData()
        }
    }
}

extension CategoriesViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.categories.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CategoryTableViewCell
        cell.setupValues(text: (viewModel?.categories[indexPath.row].name)!)
        cell.accessoryType = .detailDisclosureButton
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let category = viewModel?.categories[indexPath.row] {
            showQuestions(for: category)
        }
    }
    
    private func showQuestions(for category: Category) {
        let questionViewController = QuestionViewController(nibName: "QuestionViewController", bundle: nil)
        questionViewController.title = category.name
        questionViewController.categoryID = category.id
        navigationController?.pushViewController(questionViewController, animated: true)
    }
}
