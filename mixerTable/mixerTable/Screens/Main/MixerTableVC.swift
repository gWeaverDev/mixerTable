//
//  MixerTableVC.swift
//  mixerTable
//
//  Created by George Weaver on 11.05.2023.
//

import UIKit

class MixerTableVC: UIViewController {
    
    private let tableView: CustomTableView
    private var dataModel = Model.make()
    
    init() {
        self.tableView = CustomTableView(style: .grouped)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setupLayout()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
        setupAppearance()
    }
    
    private func setupNavigation() {
        guard let nav = navigationController?.navigationBar else { return }
        
        let navAppearance = UINavigationBarAppearance()
        
        navAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navAppearance.configureWithOpaqueBackground()
        navAppearance.backgroundColor = .white.withAlphaComponent(0.1)
        
        nav.standardAppearance = navAppearance
        nav.scrollEdgeAppearance = navAppearance
        
        nav.tintColor = .systemBlue
        nav.topItem?.title = "Task 4"
        
        let reloadItem = UIBarButtonItem(
            image: UIImage(systemName: "arrow.clockwise"),
            style: .done,
            target: self,
            action: #selector(reloadTapped)
        )
        
        let shuffleItem = UIBarButtonItem(
            title: "Shuffle",
            style: .done,
            target: self,
            action: #selector(shuffleTapped)
        )
        nav.topItem?.rightBarButtonItems = [shuffleItem]
        nav.topItem?.leftBarButtonItems = [reloadItem]
    }
    
    private func setupAppearance() {
        view.backgroundColor = .white.withAlphaComponent(0.95)
    }
    
    private func setupLayout() {
        view.addSubviewsWithoutAutoresizing(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureTableView() {
        tableView.register(IndexCell.self, forCellReuseIdentifier: IndexCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc
    private func shuffleTapped(_ sender: UIBarButtonItem) {
        tableView.performBatchUpdates {
            dataModel.shuffle()
            tableView.reloadSections(IndexSet(integer: 0), with: .bottom)
        }
    }
    
    @objc
    private func reloadTapped(_ sender: UIBarButtonItem) {
        tableView.performBatchUpdates {
            dataModel.sort { $0.number < $1.number }
            dataModel = dataModel.map {
                var some = $0
                if some.isCheckmark == true {
                    some.isCheckmark = false
                }
                return some
            }
            tableView.reloadSections(IndexSet(integer: 0), with: .bottom)
        }
    }

}

extension MixerTableVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = self.tableView.cellForRow(at: indexPath) else { fatalError() }
        
        if cell.accessoryType != .checkmark {
            cell.accessoryType = .checkmark
            dataModel[indexPath.row].isCheckmark = true
            tableView.deselectRow(at: indexPath, animated: true)
            tableView.moveRow(at: indexPath, to: IndexPath(row: 0, section: 0))
            dataModel.insert(dataModel[indexPath.row], at: 0)
            dataModel.remove(at: indexPath.row + 1)
        } else {
            cell.accessoryType = .none
            dataModel[indexPath.row].isCheckmark = false
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}

extension MixerTableVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: IndexCell.reuseIdentifier,
            for: indexPath) as? IndexCell else { fatalError() }
        
        cell.fill(dataModel[indexPath.row])
        
        return cell
    }
}
