//
//  RewardListViewController.swift
//  Lordyal
//
//  Created by Nguyen Hoang Phuc on 28/04/2023.
//

import Foundation
import UIKit

class RewardListViewController: UIViewController {
    let titleLabel: UILabel = {
        let label = UILabel()

        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 36, weight: .bold)
        label.textColor = .mediumGreen
        label.text = "Your Rewards"

        return label
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none

        tableView.register(RewardItemTableViewCell.self, forCellReuseIdentifier: RewardItemTableViewCell.identifier)

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    private func setupViews() {
        view.backgroundColor = .lightGreen
        view.addSubview(titleLabel)
        view.addSubview(tableView)
    }

    private func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(24)
            make.leading.trailing.equalToSuperview().inset(40)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(40)
            make.bottom.equalToSuperview()
        }
    }
}

extension RewardListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RewardItemTableViewCell.identifier,
            for: indexPath
        ) as? RewardItemTableViewCell else {
            return UITableViewCell()
        }

        cell.model = RewardItemModel(
            storeName: "Racket Basket",
            rewardDescription: "Free Scoop",
            progress: .inProgress(value: 5, total: 6),
            imageURL: ""
        )

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}
