//
//  CategoryTableViewCell.swift
//  Trivia
//
//  Created by Sebastian San Blas on 02/11/2021.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    let icon = UIImageView()
    let label = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
        startUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startUI() {
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        // Icon
        icon.tintColor = .blue
        icon.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(icon)
        // Label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        contentView.addSubview(label)
        // Constraints
        NSLayoutConstraint.activate([
            icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            icon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            icon.heightAnchor.constraint(equalToConstant: 40),
            icon.widthAnchor.constraint(equalToConstant: 40),
            label.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 30),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func setupValues(text: String) {
        icon.image = UIImage(systemName: getIcon())
        label.text = text
    }
}

extension CategoryTableViewCell {
    
    func getIcon() -> String {
        let array: [String] = ["pencil",
        "scribble",
        "highlighter",
        "square.and.arrow.up.on.square",
        "tray",
        "doc",
        "power",
        "cloud.bolt",
        "drop.circle.fill",
        "infinity.circle",
        "bolt.heart",
        "star.square.fill",
        "bell.slash.circle",
        "star.bubble",
        "phone.down",
        "bag",
        "wrench.fill",
        "scanner",
        "building.columns"]
        return array.randomElement() ?? "pencil"
    }
}
