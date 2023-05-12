//
//  CustonTableView.swift
//  mixerTable
//
//  Created by George Weaver on 11.05.2023.
//

import UIKit

final class CustomTableView: UITableView {
    
    init(style: UITableView.Style) {
        super.init(frame: .zero, style: style)
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAppearance() {
        backgroundColor = .white
        layer.cornerRadius = 20
        allowsMultipleSelection = true
        bounces = false
    }
}
