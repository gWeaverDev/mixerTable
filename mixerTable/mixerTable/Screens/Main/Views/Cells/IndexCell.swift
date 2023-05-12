//
//  IndexCell.swift
//  mixerTable
//
//  Created by George Weaver on 11.05.2023.
//

import UIKit

struct Model {
    let number: Int
    var isCheckmark: Bool
}

final class IndexCell: UITableViewCell {
    
    static var reuseIdentifier: String {
        String(describing: self)
    }
    
    private let numberLable = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(_ model: Model) {
        numberLable.text = String(model.number)
        accessoryType = model.isCheckmark ? .checkmark : .none
    }
    
    private func setupAppearance() {
        backgroundColor = .white
        selectionStyle = .none
        numberLable.textColor = .black
    }
    
    private func setupLayout() {
        contentView.addSubviewsWithoutAutoresizing(numberLable)
        
        NSLayoutConstraint.activate([
            numberLable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            numberLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            numberLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            numberLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
    
}

extension Model {
    
    static func make() -> [Model] {
        var data: [Model] = []
        
        for i in 1...30 {
            let item = Model(number: i, isCheckmark: false)
            data.append(item)
        }
        
        return data
    }
}


